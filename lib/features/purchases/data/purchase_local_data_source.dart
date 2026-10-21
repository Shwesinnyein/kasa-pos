import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../domain/entities/purchase_models.dart';
import '../domain/purchase_math.dart';

class PurchaseLocalDataSource {
  PurchaseLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<List<PurchaseSummary>> loadList() async {
    final purchases = await _db.select(_db.purchases).get();
    final suppliers = await _db.select(_db.suppliers).get();
    final lines = await _db.select(_db.purchaseLines).get();
    final products = await _db.select(_db.products).get();
    final units = await _db.select(_db.units).get();
    final names = {for (final supplier in suppliers) supplier.id: supplier.nameMm ?? supplier.nameEn ?? ''};
    final productById = {for (final product in products) product.id: product};
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    final linesByPurchase = <String, List<PurchaseLineView>>{};
    for (final line in lines) {
      final product = productById[line.productId];
      linesByPurchase.putIfAbsent(line.purchaseId, () => []).add(
        PurchaseLineView(
          productId: line.productId,
          nameMm: product?.nameMm ?? '',
          unitMm: unitName[product?.unitId] ?? '',
          qty: line.qty,
          unitCost: line.unitCost,
          lineTotal: line.lineTotal,
          packSize: line.packSize,
        ),
      );
    }
    final items = [
      for (final purchase in purchases)
        PurchaseSummary(
          id: purchase.id,
          purchaseNo: purchase.purchaseNo,
          purchasedAt: purchase.purchasedAt,
          supplierName: purchase.supplierId == null ? null : names[purchase.supplierId],
          total: purchase.total,
          pending: purchase.syncStatus == 'pending',
          lines: linesByPurchase[purchase.id] ?? const [],
        ),
    ];
    items.sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
    return items;
  }

  Future<PurchaseCatalog> loadCatalog() async {
    final categories = await (_db.select(_db.categories)..where((row) => row.isActive.equals(true))..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).get();
    final units = await _db.select(_db.units).get();
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    final products = await (_db.select(_db.products)..where((row) => row.isActive.equals(true))).get();
    final suppliers = await _db.select(_db.suppliers).get();
    final supplierNames = [for (final supplier in suppliers) supplier.nameMm ?? ''].where((name) => name.isNotEmpty).toList()..sort();

    return PurchaseCatalog(
      categories: [
        for (final category in categories) PurchaseCategory(id: category.id, nameMm: category.nameMm ?? category.nameEn ?? ''),
      ],
      products: [
        for (final product in products)
          PurchaseProduct(
            id: product.id,
            categoryId: product.categoryId,
            nameMm: product.nameMm ?? product.nameEn ?? '',
            unitMm: unitName[product.unitId] ?? '',
            cost: product.cost,
            barcode: product.barcode,
            packSize: product.packSize,
            buyPrice: product.buyPrice,
            packBuyPrice: product.packBuyPrice,
          ),
      ]..sort((a, b) => a.nameMm.compareTo(b.nameMm)),
      suppliers: supplierNames,
      units: [
        for (final unit in units)
          if ((unit.nameMm ?? '').isNotEmpty) PurchaseUnit(id: unit.id, nameMm: unit.nameMm!),
      ]..sort((a, b) => a.nameMm.compareTo(b.nameMm)),
    );
  }

  /// A brand that is not in the catalog yet. Selling price stays empty until ရောင်းဈေး.
  Future<({PurchaseProduct? product, String? error})> createProduct({
    required String name,
    required String categoryId,
    required String unitId,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return (product: null, error: 'အမည်ဖြည့်ပါ။');
    final units = await _db.select(_db.units).get();
    String? unitMm;
    for (final unit in units) {
      if (unit.id == unitId) unitMm = unit.nameMm;
    }
    if (unitMm == null || unitMm.isEmpty) return (product: null, error: 'ယူနစ်ရွေးပါ။');
    final existing = await (_db.select(_db.products)..where((row) => row.isActive.equals(true))).get();
    for (final product in existing) {
      if ((product.nameMm ?? '').trim() == trimmed && product.categoryId == categoryId) {
        return (
          product: PurchaseProduct(id: product.id, categoryId: product.categoryId, nameMm: trimmed, unitMm: unitMm, cost: product.cost, packSize: product.packSize, buyPrice: product.buyPrice, packBuyPrice: product.packBuyPrice),
          error: null,
        );
      }
    }
    final id = _uuid.v4();
    await _db.into(_db.products).insert(
      ProductsCompanion.insert(
        id: id,
        shopId: DatabaseSeeder.shopId,
        categoryId: categoryId,
        unitId: unitId,
        nameMm: Value(trimmed),
        price: 0,
        cost: const Value(0),
        deviceId: const Value(DatabaseSeeder.deviceId),
        syncStatus: const Value('pending'),
        updatedAt: DateTime.now(),
      ),
    );
    return (product: PurchaseProduct(id: id, categoryId: categoryId, nameMm: trimmed, unitMm: unitMm, cost: 0), error: null);
  }

  Future<PurchaseDetail> loadDetail(String id) async {
    final purchase = await (_db.select(_db.purchases)..where((row) => row.id.equals(id))).getSingle();
    final lines = await (_db.select(_db.purchaseLines)..where((row) => row.purchaseId.equals(id))).get();
    final products = await _db.select(_db.products).get();
    final units = await _db.select(_db.units).get();
    final productById = {for (final product in products) product.id: product};
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    String? supplierName;
    if (purchase.supplierId != null) {
      final supplier = await (_db.select(_db.suppliers)..where((row) => row.id.equals(purchase.supplierId!))).getSingleOrNull();
      supplierName = supplier?.nameMm;
    }
    return PurchaseDetail(
      id: purchase.id,
      purchaseNo: purchase.purchaseNo,
      purchasedAt: purchase.purchasedAt,
      supplierName: supplierName,
      total: purchase.total,
      pending: purchase.syncStatus == 'pending',
      lines: [
        for (final line in lines)
          PurchaseLineView(
            productId: line.productId,
            nameMm: productById[line.productId]?.nameMm ?? '',
            unitMm: unitName[productById[line.productId]?.unitId] ?? '',
            qty: line.qty,
            unitCost: line.unitCost,
            lineTotal: line.lineTotal,
            packSize: line.packSize,
          ),
      ],
    );
  }

  /// Returns the new purchase id and number, or a Myanmar error message in [error].
  Future<({String? id, String? no, String? error})> save(NewPurchase purchase) async {
    final lines = purchase.lines.where((line) => line.qty > 0).toList();
    if (lines.isEmpty) return (id: null, no: null, error: 'ကုန်ပစ္စည်းတစ်ခုထည့်ပါ။');
    if (lines.any((line) => line.unitCost < 0)) return (id: null, no: null, error: 'အဝယ်ဈေးဖြည့်ပါ။');

    final now = DateTime.now();
    final purchaseId = _uuid.v4();
    try {
      final number = await _db.transaction(() async {
        final existing = await _db.select(_db.purchases).get();
        final purchaseNo = 'P${(existing.length + 1).toString().padLeft(4, '0')}';
        final supplierId = await _supplierId(purchase.supplierName, now);
        final total = lines.fold<double>(0, (sum, line) => sum + line.qty * line.unitCost);
        await _db.into(_db.purchases).insert(
          PurchasesCompanion.insert(
            id: purchaseId,
            shopId: DatabaseSeeder.shopId,
            deviceId: DatabaseSeeder.deviceId,
            supplierId: Value(supplierId),
            staffId: purchase.staffId,
            purchaseNo: purchaseNo,
            purchasedAt: purchase.purchasedAt,
            total: total,
            createdAt: now,
            updatedAt: now,
          ),
        );
        for (final line in lines) {
          await _writeLine(purchaseId: purchaseId, line: line, happenedAt: purchase.purchasedAt, now: now);
        }
        return purchaseNo;
      });
      return (id: purchaseId, no: number, error: null);
    } catch (_) {
      return (id: null, no: null, error: 'သိမ်းမရပါ။');
    }
  }

  Future<({String? id, String? no, String? error})> update(String purchaseId, NewPurchase purchase) async {
    final lines = purchase.lines.where((line) => line.qty > 0).toList();
    if (lines.isEmpty) return (id: null, no: null, error: 'ကုန်ပစ္စည်းတစ်ခုထည့်ပါ။');
    if (lines.any((line) => line.unitCost < 0)) return (id: null, no: null, error: 'အဝယ်ဈေးဖြည့်ပါ။');

    final now = DateTime.now();
    try {
      final number = await _db.transaction(() async {
        final current = await (_db.select(_db.purchases)..where((row) => row.id.equals(purchaseId))).getSingle();
        final oldLines = await (_db.select(_db.purchaseLines)..where((row) => row.purchaseId.equals(purchaseId))).get();
        for (final old in oldLines) {
          await _reverseLine(old);
        }
        await (_db.delete(_db.purchaseLines)..where((row) => row.purchaseId.equals(purchaseId))).go();
        final supplierId = await _supplierId(purchase.supplierName, now);
        final total = lines.fold<double>(0, (sum, line) => sum + line.qty * line.unitCost);
        await (_db.update(_db.purchases)..where((row) => row.id.equals(purchaseId))).write(
          PurchasesCompanion(
            supplierId: Value(supplierId),
            purchasedAt: Value(purchase.purchasedAt),
            total: Value(total),
            syncStatus: const Value('pending'),
            updatedAt: Value(now),
          ),
        );
        for (final line in lines) {
          await _writeLine(purchaseId: purchaseId, line: line, happenedAt: purchase.purchasedAt, now: now);
        }
        return current.purchaseNo;
      });
      return (id: purchaseId, no: number, error: null);
    } catch (_) {
      return (id: null, no: null, error: 'သိမ်းမရပါ။');
    }
  }

  Future<void> _reverseLine(PurchaseLine old) async {
    final product = await (_db.select(_db.products)..where((row) => row.id.equals(old.productId))).getSingle();
    final movements = await (_db.select(_db.stockMovements)..where((row) => row.productId.equals(old.productId))).get();
    final onHand = movements.fold<double>(0, (sum, movement) => sum + movement.qtyChange);
    final received = baseQty(qty: old.qty, packSize: old.packSize);
    final each = baseUnitCost(unitCost: old.unitCost, packSize: old.packSize);
    final before = onHand - received;
    var restored = product.cost;
    if (before > 0) {
      restored = (product.cost * onHand - received * each) / before;
      if (restored < 0) restored = 0;
    } else {
      restored = 0;
    }
    await (_db.delete(_db.stockMovements)..where((row) => row.sourceId.equals(old.id) & row.sourceType.equals('purchase'))).go();
    await (_db.update(_db.products)..where((row) => row.id.equals(old.productId))).write(
      ProductsCompanion(cost: Value(restored), updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> _writeLine({
    required String purchaseId,
    required NewPurchaseLine line,
    required DateTime happenedAt,
    required DateTime now,
  }) async {
    final product = await (_db.select(_db.products)..where((row) => row.id.equals(line.productId))).getSingle();
    final movements = await (_db.select(_db.stockMovements)..where((row) => row.productId.equals(line.productId))).get();
    final onHand = movements.fold<double>(0, (sum, movement) => sum + movement.qtyChange);
    final received = baseQty(qty: line.qty, packSize: line.packSize);
    final eachCost = baseUnitCost(unitCost: line.unitCost, packSize: line.packSize);
    final nextCost = weightedAverageCost(
      onHand: onHand,
      currentCost: product.cost,
      receivedQty: received,
      receivedCost: eachCost,
    );
    final lineId = _uuid.v4();
    await _db.into(_db.purchaseLines).insert(
      PurchaseLinesCompanion.insert(
        id: lineId,
        purchaseId: purchaseId,
        productId: line.productId,
        qty: line.qty,
        unitCost: line.unitCost,
        lineTotal: line.qty * line.unitCost,
        packSize: Value(line.packSize),
      ),
    );
    await _db.into(_db.stockMovements).insert(
      StockMovementsCompanion.insert(
        id: _uuid.v4(),
        shopId: DatabaseSeeder.shopId,
        productId: line.productId,
        sourceType: 'purchase',
        sourceId: lineId,
        qtyChange: received,
        unitCost: eachCost,
        happenedAt: happenedAt,
      ),
    );
    await (_db.update(_db.products)..where((row) => row.id.equals(line.productId))).write(
      ProductsCompanion(
        cost: Value(nextCost),
        packSize: line.packSize > 1 ? Value(line.packSize) : const Value.absent(),
        syncStatus: const Value('pending'),
        updatedAt: Value(now),
      ),
    );
  }

  Future<List<PurchasePriceChange>> loadPriceHistory(String productId) async {
    final lines = await (_db.select(_db.purchaseLines)..where((row) => row.productId.equals(productId))).get();
    final purchases = await _db.select(_db.purchases).get();
    final byId = {for (final purchase in purchases) purchase.id: purchase};
    final points = [
      for (final line in lines)
        if (byId[line.purchaseId] != null)
          (
            purchasedAt: byId[line.purchaseId]!.purchasedAt,
            purchaseNo: byId[line.purchaseId]!.purchaseNo,
            paid: line.unitCost,
            packSize: line.packSize,
          ),
    ]..sort((a, b) {
        final byDate = a.purchasedAt.compareTo(b.purchasedAt);
        if (byDate != 0) return byDate;
        return a.purchaseNo.compareTo(b.purchaseNo);
      });
    final history = <PurchasePriceChange>[];
    double? previousEach;
    for (final point in points) {
      final each = baseUnitCost(unitCost: point.paid, packSize: point.packSize <= 0 ? 1 : point.packSize);
      final move = previousEach == null
          ? PriceMove.first
          : each > previousEach + 0.001
              ? PriceMove.up
              : each < previousEach - 0.001
                  ? PriceMove.down
                  : PriceMove.same;
      history.add(
        PurchasePriceChange(
          purchasedAt: point.purchasedAt,
          purchaseNo: point.purchaseNo,
          paid: point.paid,
          each: each,
          packSize: point.packSize <= 0 ? 1 : point.packSize,
          move: move,
        ),
      );
      previousEach = each;
    }
    return history.reversed.toList();
  }

  Future<String?> _supplierId(String? name, DateTime now) async {
    final trimmed = name?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final suppliers = await _db.select(_db.suppliers).get();
    for (final supplier in suppliers) {
      if ((supplier.nameMm ?? '').trim() == trimmed) return supplier.id;
    }
    final id = _uuid.v4();
    await _db.into(_db.suppliers).insert(
      SuppliersCompanion.insert(
        id: id,
        shopId: DatabaseSeeder.shopId,
        nameMm: Value(trimmed),
        syncStatus: const Value('pending'),
        updatedAt: now,
      ),
    );
    return id;
  }
}
