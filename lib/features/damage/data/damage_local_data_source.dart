import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';

class DamageSummary {
  const DamageSummary({
    required this.id,
    required this.damageNo,
    required this.damagedAt,
    required this.productName,
    required this.unitMm,
    required this.qty,
    required this.reason,
    required this.lineCost,
    required this.pending,
  });

  final String id;
  final String damageNo;
  final DateTime damagedAt;
  final String productName;
  final String unitMm;
  final double qty;
  final String reason;
  final double lineCost;
  final bool pending;
}

class DamageLocalDataSource {
  DamageLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<List<DamageSummary>> loadList() async {
    final damages = await _db.select(_db.damages).get();
    final lines = await _db.select(_db.damageLines).get();
    final products = await _db.select(_db.products).get();
    final units = await _db.select(_db.units).get();
    final productById = {for (final product in products) product.id: product};
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    final lineByDamage = <String, DamageLine>{for (final line in lines) line.damageId: line};
    final items = [
      for (final damage in damages)
        if (lineByDamage[damage.id] != null)
          DamageSummary(
            id: damage.id,
            damageNo: damage.damageNo,
            damagedAt: damage.damagedAt,
            productName: productById[lineByDamage[damage.id]!.productId]?.nameMm ?? '',
            unitMm: unitName[productById[lineByDamage[damage.id]!.productId]?.unitId] ?? '',
            qty: lineByDamage[damage.id]!.qty,
            reason: lineByDamage[damage.id]!.reason,
            lineCost: lineByDamage[damage.id]!.lineCost,
            pending: damage.syncStatus == 'pending',
          ),
    ];
    items.sort((a, b) => b.damagedAt.compareTo(a.damagedAt));
    return items;
  }

  Future<({String? no, String? error})> save({
    required String staffId,
    required DateTime damagedAt,
    required String productId,
    required double qty,
    required String reason,
  }) async {
    if (qty <= 0) return (no: null, error: 'အရေအတွက်ဖြည့်ပါ။');
    if (reason.trim().isEmpty) return (no: null, error: 'အကြောင်းရင်းရွေးပါ။');
    final now = DateTime.now();
    try {
      final number = await _db.transaction(() async {
        final product = await (_db.select(_db.products)..where((row) => row.id.equals(productId))).getSingle();
        final movements = await (_db.select(_db.stockMovements)..where((row) => row.productId.equals(productId))).get();
        final onHand = movements.fold<double>(0, (sum, movement) => sum + movement.qtyChange);
        if (qty > onHand) return null;
        final count = await _db.select(_db.damages).get();
        final damageNo = 'D${(count.length + 1).toString().padLeft(4, '0')}';
        final damageId = _uuid.v4();
        final lineId = _uuid.v4();
        await _db.into(_db.damages).insert(
          DamagesCompanion.insert(
            id: damageId,
            shopId: DatabaseSeeder.shopId,
            deviceId: DatabaseSeeder.deviceId,
            staffId: staffId,
            damageNo: damageNo,
            damagedAt: damagedAt,
            syncStatus: const Value('pending'),
            createdAt: now,
            updatedAt: now,
          ),
        );
        await _db.into(_db.damageLines).insert(
          DamageLinesCompanion.insert(
            id: lineId,
            damageId: damageId,
            productId: productId,
            qty: qty,
            unitCost: product.cost,
            lineCost: qty * product.cost,
            reason: reason,
          ),
        );
        await _db.into(_db.stockMovements).insert(
          StockMovementsCompanion.insert(
            id: _uuid.v4(),
            shopId: DatabaseSeeder.shopId,
            productId: productId,
            sourceType: 'damage',
            sourceId: lineId,
            qtyChange: -qty,
            unitCost: product.cost,
            happenedAt: damagedAt,
          ),
        );
        return damageNo;
      });
      if (number == null) return (no: null, error: 'လက်ကျန်မလုံလောက်ပါ။');
      return (no: number, error: null);
    } catch (_) {
      return (no: null, error: 'သိမ်းမရပါ။');
    }
  }
}
