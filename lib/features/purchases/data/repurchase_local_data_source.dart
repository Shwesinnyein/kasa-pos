import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';

class RepurchaseDocument {
  const RepurchaseDocument({
    required this.id,
    required this.repurchaseNo,
    required this.createdAt,
    required this.completed,
    required this.names,
    required this.productIds,
    this.purchaseNo,
    this.total,
  });

  final String id;
  final String repurchaseNo;
  final DateTime createdAt;
  final bool completed;
  final String? purchaseNo;
  final double? total;
  final List<String> names;
  final Set<String> productIds;
}

class RepurchaseEntry {
  const RepurchaseEntry({required this.id, required this.productId, required this.qty, required this.packQty, required this.packSize});

  final String id;
  final String productId;
  final double qty;
  final double packQty;
  final double packSize;
}

class RepurchaseSheet {
  const RepurchaseSheet({required this.document, required this.items});

  final RepurchaseDocument document;
  final List<RepurchaseEntry> items;
}

class RepurchaseLocalDataSource {
  RepurchaseLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<List<RepurchaseDocument>> loadList() async {
    final finished = await (_db.select(_db.repurchases)..where((row) => row.status.equals('completed'))).get();
    for (final doc in finished) {
      await removeDocument(doc.id);
    }
    final docs = await (_db.select(_db.repurchases)..orderBy([(row) => OrderingTerm.desc(row.createdAt)])).get();
    final items = await _db.select(_db.repurchaseItems).get();
    final products = await _db.select(_db.products).get();
    final purchases = await _db.select(_db.purchases).get();
    final names = {for (final product in products) product.id: product.nameMm ?? product.nameEn ?? ''};
    final purchaseNos = {for (final purchase in purchases) purchase.id: purchase.purchaseNo};
    final purchaseTotals = {for (final purchase in purchases) purchase.id: purchase.total};
    return [
      for (final doc in docs)
        RepurchaseDocument(
          id: doc.id,
          repurchaseNo: doc.repurchaseNo,
          createdAt: doc.createdAt,
          completed: doc.status == 'completed',
          purchaseNo: doc.purchaseId == null ? null : purchaseNos[doc.purchaseId!],
          total: doc.purchaseId == null ? null : purchaseTotals[doc.purchaseId!],
          names: [
            for (final item in items.where((item) => item.repurchaseId == doc.id))
              if ((names[item.productId] ?? '').isNotEmpty) names[item.productId]!,
          ],
          productIds: {for (final item in items.where((item) => item.repurchaseId == doc.id)) item.productId},
        ),
    ];
  }

  Future<RepurchaseSheet?> loadSheet(String id) async {
    final doc = await (_db.select(_db.repurchases)..where((row) => row.id.equals(id))).getSingleOrNull();
    if (doc == null) return null;
    final list = await loadList();
    final document = list.where((item) => item.id == id).firstOrNull;
    if (document == null) return null;
    final rows = await (_db.select(_db.repurchaseItems)
          ..where((row) => row.repurchaseId.equals(id))
          ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
        .get();
    return RepurchaseSheet(
      document: document,
      items: [
        for (final row in rows) RepurchaseEntry(id: row.id, productId: row.productId, qty: row.qty, packQty: row.packQty, packSize: row.packSize),
      ],
    );
  }

  Future<String> ensureOpen() async {
    final open = await (_db.select(_db.repurchases)..where((row) => row.status.equals('open'))..orderBy([(row) => OrderingTerm.desc(row.createdAt)])).get();
    if (open.isNotEmpty) return open.first.id;
    return create();
  }

  Future<String> create() async {
    final existing = await _db.select(_db.repurchases).get();
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.repurchases).insert(
      RepurchasesCompanion.insert(
        id: id,
        shopId: DatabaseSeeder.shopId,
        repurchaseNo: 'R${(existing.length + 1).toString().padLeft(4, '0')}',
        createdAt: now,
        updatedAt: now,
      ),
    );
    return id;
  }

  /// Adds singles and packs onto the one product row inside [repurchaseId].
  Future<void> add({required String repurchaseId, required String productId, double qty = 1, double packQty = 0, double packSize = 1}) async {
    final doc = await (_db.select(_db.repurchases)..where((row) => row.id.equals(repurchaseId))).getSingleOrNull();
    if (doc == null || doc.status == 'completed') return;
    final existing = await (_db.select(_db.repurchaseItems)..where((row) => row.repurchaseId.equals(repurchaseId) & row.productId.equals(productId))).getSingleOrNull();
    final size = packSize > 1 ? packSize : null;
    if (existing == null) {
      await _db.into(_db.repurchaseItems).insert(
        RepurchaseItemsCompanion.insert(
          id: _uuid.v4(),
          shopId: DatabaseSeeder.shopId,
          repurchaseId: Value(repurchaseId),
          productId: productId,
          qty: Value(qty),
          packQty: Value(packQty),
          packSize: Value(size ?? 1),
          createdAt: DateTime.now(),
        ),
      );
      return;
    }
    await (_db.update(_db.repurchaseItems)..where((row) => row.id.equals(existing.id))).write(
      RepurchaseItemsCompanion(
        qty: Value(existing.qty + qty),
        packQty: Value(existing.packQty + packQty),
        packSize: Value(size ?? existing.packSize),
      ),
    );
  }

  Future<void> setSingle(String id, double qty) async {
    await (_db.update(_db.repurchaseItems)..where((row) => row.id.equals(id))).write(RepurchaseItemsCompanion(qty: Value(qty < 0 ? 0 : qty)));
  }

  Future<void> setPackQty(String id, double qty) async {
    await (_db.update(_db.repurchaseItems)..where((row) => row.id.equals(id))).write(RepurchaseItemsCompanion(packQty: Value(qty < 0 ? 0 : qty)));
  }

  Future<void> remove(String id) async {
    await (_db.delete(_db.repurchaseItems)..where((row) => row.id.equals(id))).go();
  }

  /// The purchase now holds these lines, so the repurchase document is removed.
  Future<void> removeDocument(String id) async {
    await (_db.delete(_db.repurchaseItems)..where((row) => row.repurchaseId.equals(id))).go();
    await (_db.delete(_db.repurchases)..where((row) => row.id.equals(id))).go();
  }
}
