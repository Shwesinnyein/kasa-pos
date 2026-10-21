import 'dart:io';

import 'package:drift/drift.dart';

import '../../features/auth/data/pin_hasher.dart';
import 'app_database.dart';

/// First launch writes one shop, this device, and two staff PINs.
/// Owner PIN is 1111. Cashier PIN is 2222.
class DatabaseSeeder {
  DatabaseSeeder(this._db);

  final AppDatabase _db;

  static const shopId = 'shop-kasa';
  static const deviceId = 'device-this-register';

  Future<void> seedIfEmpty() async {
    final existing = await _db.select(_db.shops).get();
    if (existing.isEmpty) {
      await _seedShop();
    }
    await _seedCatalog(DateTime.now());
    await _seedOpeningStock(DateTime.now());
  }

  Future<void> _seedShop() async {
    final now = DateTime.now();
    await _db.batch((batch) {
      batch.insert(
        _db.shops,
        ShopsCompanion.insert(
          id: shopId,
          nameEn: const Value('Kasa Shop'),
          nameMm: const Value('ကမ္ဘာဆိုင်'),
          createdAt: now,
        ),
      );
      batch.insert(
        _db.devices,
        DevicesCompanion.insert(
          id: deviceId,
          shopId: shopId,
          name: 'Counter 1',
          platform: _platform(),
        ),
      );
      batch.insertAll(_db.staff, [
        StaffCompanion.insert(
          id: 'staff-owner',
          shopId: shopId,
          name: 'မောင်မောင်',
          role: 'owner',
          pinHash: hashPin('1111'),
        ),
        StaffCompanion.insert(
          id: 'staff-cashier',
          shopId: shopId,
          name: 'ခင်ခင်',
          role: 'cashier',
          pinHash: hashPin('2222'),
        ),
      ]);
      batch.insertAll(_db.units, [
        UnitsCompanion.insert(id: 'unit-pack', shopId: shopId, nameEn: const Value('pack'), nameMm: const Value('ထုပ်'), updatedAt: now),
        UnitsCompanion.insert(id: 'unit-bottle', shopId: shopId, nameEn: const Value('bottle'), nameMm: const Value('ပုလင်း'), updatedAt: now),
        UnitsCompanion.insert(id: 'unit-piece', shopId: shopId, nameEn: const Value('piece'), nameMm: const Value('လုံး'), updatedAt: now),
        UnitsCompanion.insert(id: 'unit-kg', shopId: shopId, nameEn: const Value('kg'), nameMm: const Value('ကီလို'), updatedAt: now),
      ]);
      batch.insertAll(_db.expenseCategories, [
        ExpenseCategoriesCompanion.insert(id: 'exp-rent', shopId: shopId, nameEn: const Value('Rent'), nameMm: const Value('အိမ်လခ'), updatedAt: now),
        ExpenseCategoriesCompanion.insert(id: 'exp-wages', shopId: shopId, nameEn: const Value('Wages'), nameMm: const Value('လစာ'), updatedAt: now),
        ExpenseCategoriesCompanion.insert(id: 'exp-electric', shopId: shopId, nameEn: const Value('Electric'), nameMm: const Value('မီးစက်'), updatedAt: now),
        ExpenseCategoriesCompanion.insert(id: 'exp-transport', shopId: shopId, nameEn: const Value('Transport'), nameMm: const Value('သယ်ယူပို့ဆောင်'), updatedAt: now),
      ]);
    });
    await _seedCatalog(now);
    await _seedOpeningStock(now);
  }

  Future<void> _seedCatalog(DateTime now) async {
    final products = await _db.select(_db.products).get();
    if (products.isNotEmpty) return;

    const categories = [
      ('cat-food', 'စားသောက်ကုန်', 1),
      ('cat-drink', 'အချိုရည်', 2),
      ('cat-clean', 'သန့်ရှင်းရေး', 3),
      ('cat-beauty', 'အလှကုန်', 4),
      ('cat-grocery', 'ကုန်စုံ', 5),
      ('cat-baby', 'ကလေးပစ္စည်း', 6),
      ('cat-home', 'အိမ်သုံးပစ္စည်း', 7),
      ('cat-other', 'အခြား', 8),
    ];
    const items = [
      ('p-snack', 'cat-food', 'unit-pack', 'မုန့်', 2500, 1800, '885000000001'),
      ('p-water', 'cat-drink', 'unit-bottle', 'ရေသန့်', 800, 400, '885000000002'),
      ('p-tissue', 'cat-home', 'unit-pack', 'တစ်ရှူး', 1200, 700, '885000000003'),
      ('p-chips', 'cat-food', 'unit-pack', 'အာလူးချောင်းကြော်', 3500, 2500, '885000000004'),
      ('p-milk', 'cat-drink', 'unit-piece', 'နို့', 2800, 2000, '885000000005'),
      ('p-coffee', 'cat-drink', 'unit-pack', 'ကော်ဖီ', 4500, 3200, '885000000006'),
      ('p-tea', 'cat-drink', 'unit-pack', 'လက်ဖက်ရည်', 3000, 2100, '885000000007'),
      ('p-fish', 'cat-food', 'unit-piece', 'ငါးသေတ္တာ', 3200, 2400, '885000000008'),
      ('p-oil', 'cat-grocery', 'unit-bottle', 'ဆီ', 6500, 5000, '885000000009'),
      ('p-sauce', 'cat-grocery', 'unit-bottle', 'ပဲငံပြာရည်', 2000, 1400, '885000000010'),
      ('p-noodle', 'cat-food', 'unit-piece', 'ခေါက်ဆွဲ', 1800, 1200, '885000000011'),
      ('p-powder', 'cat-clean', 'unit-pack', 'အဝတ်လျှော်မှုန့်', 4000, 2800, '885000000012'),
      ('p-soap', 'cat-clean', 'unit-piece', 'ဆပ်ပြာ', 1000, 600, '885000000013'),
      ('p-shampoo', 'cat-beauty', 'unit-bottle', 'ခေါင်းလျှော်ရည်', 3200, 2200, '885000000014'),
      ('p-paste', 'cat-beauty', 'unit-piece', 'သွားတိုက်ဆေး', 2500, 1600, '885000000015'),
      ('p-roll', 'cat-home', 'unit-piece', 'အိမ်သာစက္ကူ', 4200, 3000, '885000000016'),
    ];

    await _db.batch((batch) {
      batch.insertAll(_db.categories, [
        for (final category in categories)
          CategoriesCompanion.insert(
            id: category.$1,
            shopId: shopId,
            nameMm: Value(category.$2),
            sortOrder: Value(category.$3),
            updatedAt: now,
          ),
      ]);
      batch.insertAll(_db.products, [
        for (final item in items)
          ProductsCompanion.insert(
            id: item.$1,
            shopId: shopId,
            categoryId: item.$2,
            unitId: item.$3,
            nameMm: Value(item.$4),
            price: item.$5.toDouble(),
            cost: Value(item.$6.toDouble()),
            barcode: Value(item.$7),
            updatedAt: now,
          ),
      ]);
    });
  }

  Future<void> _seedOpeningStock(DateTime now) async {
    const levels = {
      'p-snack': 5.0,
      'p-water': 10.0,
      'p-tissue': 5.0,
      'p-chips': 5.0,
      'p-milk': 6.0,
      'p-coffee': 4.0,
      'p-tea': 4.0,
      'p-fish': 6.0,
      'p-oil': 4.0,
      'p-sauce': 6.0,
      'p-noodle': 8.0,
      'p-powder': 4.0,
      'p-soap': 10.0,
      'p-shampoo': 4.0,
      'p-paste': 5.0,
      'p-roll': 4.0,
    };
    const onHand = {
      'p-snack': 24.0,
      'p-water': 8.0,
      'p-tissue': 15.0,
      'p-chips': 3.0,
      'p-milk': 12.0,
      'p-coffee': 6.0,
      'p-tea': 9.0,
      'p-fish': 4.0,
      'p-oil': 7.0,
      'p-sauce': 11.0,
      'p-noodle': 18.0,
      'p-powder': 5.0,
      'p-soap': 2.0,
      'p-shampoo': 8.0,
      'p-paste': 10.0,
      'p-roll': 6.0,
    };

    final products = await _db.select(_db.products).get();
    for (final product in products) {
      final level = levels[product.id];
      if (level != null && product.reorderLevel == null) {
        await (_db.update(_db.products)..where((row) => row.id.equals(product.id))).write(ProductsCompanion(reorderLevel: Value(level)));
      }
    }

    final movements = await _db.select(_db.stockMovements).get();
    if (movements.isNotEmpty) return;
    await _db.batch((batch) {
      for (final entry in onHand.entries) {
        batch.insert(
          _db.stockMovements,
          StockMovementsCompanion.insert(
            id: 'open-${entry.key}',
            shopId: shopId,
            productId: entry.key,
            sourceType: 'purchase',
            sourceId: 'open-${entry.key}',
            qtyChange: entry.value,
            unitCost: 0,
            happenedAt: now,
          ),
        );
      }
    });
  }

  String _platform() {
    if (Platform.isAndroid || Platform.isIOS) return 'tablet';
    return 'desktop';
  }
}
