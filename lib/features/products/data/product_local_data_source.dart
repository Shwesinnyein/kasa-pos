import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../domain/entities/product_form_data.dart';
import '../domain/entities/product_list_item.dart';

class ProductLocalDataSource {
  const ProductLocalDataSource(this._db);

  final AppDatabase _db;

  Future<List<ProductListItem>> load() async {
    final products = await (_db.select(_db.products)..where((row) => row.isActive.equals(true))).get();
    final categories = await _db.select(_db.categories).get();
    final units = await _db.select(_db.units).get();
    final movements = await _db.select(_db.stockMovements).get();
    final saleLines = await _db.select(_db.saleLines).get();
    final categoryName = {for (final category in categories) category.id: category.nameMm ?? category.nameEn ?? ''};
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    final stock = <String, double>{};
    for (final movement in movements) {
      stock[movement.productId] = (stock[movement.productId] ?? 0) + movement.qtyChange;
    }
    final soldQty = <String, double>{};
    final soldAmount = <String, double>{};
    for (final line in saleLines) {
      final size = line.packSize <= 0 ? 1.0 : line.packSize;
      soldQty[line.productId] = (soldQty[line.productId] ?? 0) + line.qty * size;
      soldAmount[line.productId] = (soldAmount[line.productId] ?? 0) + line.lineTotal;
    }

    final items = [
      for (final product in products)
        ProductListItem(
          id: product.id,
          nameMm: product.nameMm ?? product.nameEn ?? '',
          categoryId: product.categoryId,
          categoryName: categoryName[product.categoryId] ?? '',
          unitMm: unitName[product.unitId] ?? '',
          price: product.price,
          cost: product.cost,
          packPrice: product.packPrice,
          packSize: product.packSize,
          buyPrice: product.buyPrice,
          packBuyPrice: product.packBuyPrice,
          previousPrice: product.previousPrice,
          previousPackPrice: product.previousPackPrice,
          stock: stock[product.id] ?? 0,
          soldQty: soldQty[product.id] ?? 0,
          soldAmount: soldAmount[product.id] ?? 0,
          reorderLevel: product.reorderLevel,
        ),
    ];
    items.sort((a, b) => a.nameMm.compareTo(b.nameMm));
    return items;
  }

  Future<ProductFormData> loadForm(String? productId) async {
    final categories = await (_db.select(_db.categories)..where((row) => row.isActive.equals(true))..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).get();
    final units = await (_db.select(_db.units)..orderBy([(row) => OrderingTerm.asc(row.nameMm)])).get();
    final categoryOptions = [for (final category in categories) NamedOption(category.id, category.nameMm ?? category.nameEn ?? '')];
    final unitOptions = [for (final unit in units) NamedOption(unit.id, unit.nameMm ?? unit.nameEn ?? '')];

    if (productId == null) {
      return ProductFormData(categories: categoryOptions, units: unitOptions);
    }

    final product = await (_db.select(_db.products)..where((row) => row.id.equals(productId))).getSingle();
    if (!categoryOptions.any((category) => category.id == product.categoryId)) {
      final category = await (_db.select(_db.categories)..where((row) => row.id.equals(product.categoryId))).getSingleOrNull();
      if (category != null) {
        categoryOptions.insert(0, NamedOption(category.id, category.nameMm ?? category.nameEn ?? ''));
      }
    }
    return ProductFormData(
      categories: categoryOptions,
      units: unitOptions,
      id: product.id,
      nameMm: product.nameMm ?? '',
      categoryId: product.categoryId,
      unitId: product.unitId,
      barcode: product.barcode ?? '',
      price: product.price,
      reorderLevel: product.reorderLevel,
      cost: product.cost,
    );
  }

  /// Returns a Myanmar error message, or null when the product is stored.
  Future<String?> save(ProductDraft draft) async {
    final name = draft.nameMm.trim();
    if (name.isEmpty) return 'အမည်ဖြည့်ပါ။';
    if (draft.categoryId == null) return 'အမျိုးအစားရွေးပါ။';

    final barcode = _barcode(draft.barcode);
    if (barcode != null) {
      final taken = await (_db.select(_db.products)..where((row) => row.barcode.equals(barcode))).get();
      if (taken.any((product) => product.id != draft.id)) return 'ဘားကုဒ် ရှိပြီးသားဖြစ်သည်။';
    }

    final unitId = await _unitId(draft.unitId, draft.unitName);
    if (unitId == null) return 'ထုပ်ပိုးပုံရွေးပါ။';

    final now = DateTime.now();
    if (draft.id == null) {
      await _db.into(_db.products).insert(
        ProductsCompanion.insert(
          id: _uuid.v4(),
          shopId: DatabaseSeeder.shopId,
          categoryId: draft.categoryId!,
          unitId: unitId,
          nameMm: Value(name),
          barcode: Value(barcode),
          price: 0,
          cost: const Value(0),
          reorderLevel: Value(draft.reorderLevel),
          deviceId: const Value(DatabaseSeeder.deviceId),
          syncStatus: const Value('pending'),
          updatedAt: now,
        ),
      );
      return null;
    }

    await (_db.update(_db.products)..where((row) => row.id.equals(draft.id!))).write(
      ProductsCompanion(
        categoryId: Value(draft.categoryId!),
        unitId: Value(unitId),
        nameMm: Value(name),
        barcode: Value(barcode),
        reorderLevel: Value(draft.reorderLevel),
        deviceId: const Value(DatabaseSeeder.deviceId),
        syncStatus: const Value('pending'),
        updatedAt: Value(now),
      ),
    );
    return null;
  }

  /// Stores the packaging word by itself. No product is created.
  Future<({String? id, String? error})> addUnit(String name) async {
    final typed = name.trim();
    if (typed.isEmpty) return (id: null, error: 'ထုပ်ပိုးပုံရိုက်ပါ။');
    final id = await _unitId(null, typed);
    return (id: id, error: null);
  }

  Future<String?> _unitId(String? selectedId, String typedName) async {
    final typed = typedName.trim();
    if (typed.isNotEmpty) {
      final units = await _db.select(_db.units).get();
      for (final unit in units) {
        if ((unit.nameMm ?? '').trim() == typed) return unit.id;
      }
      final id = _uuid.v4();
      await _db.into(_db.units).insert(
        UnitsCompanion.insert(
          id: id,
          shopId: DatabaseSeeder.shopId,
          nameMm: Value(typed),
          syncStatus: const Value('pending'),
          updatedAt: DateTime.now(),
        ),
      );
      return id;
    }
    if (selectedId == null) return null;
    final selected = await (_db.select(_db.units)..where((row) => row.id.equals(selectedId))).getSingleOrNull();
    return selected?.id;
  }

  Future<String?> setPrices(String id, {required double price, double? packPrice, double? packSize, double? buyPrice, double? packBuyPrice}) async {
    if (price <= 0) return 'တစ်ခုချင်း ရောင်းဈေးဖြည့်ပါ။';
    if ((packPrice != null || packBuyPrice != null) && (packSize == null || packSize <= 1)) return '၁ ဖာတွင် အရေအတွက်ဖြည့်ပါ။';
    final current = await (_db.select(_db.products)..where((row) => row.id.equals(id))).getSingleOrNull();
    if (current == null) return 'ကုန်ပစ္စည်းမရှိပါ။';
    await (_db.update(_db.products)..where((row) => row.id.equals(id))).write(
      ProductsCompanion(
        price: Value(price),
        packPrice: Value(packPrice),
        packSize: packPrice == null && packBuyPrice == null ? const Value.absent() : Value(packSize),
        buyPrice: Value(buyPrice),
        packBuyPrice: Value(packBuyPrice),
        previousPrice: Value(_keptPrevious(current.price, price, current.previousPrice)),
        previousPackPrice: Value(_keptPrevious(current.packPrice, packPrice, current.previousPackPrice)),
        syncStatus: const Value('pending'),
        deviceId: const Value(DatabaseSeeder.deviceId),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return null;
  }

  double? _keptPrevious(double? oldPrice, double? newPrice, double? already) {
    if (oldPrice != null && oldPrice > 0 && oldPrice != newPrice) return oldPrice;
    return already;
  }

  String? _barcode(String input) {
    final converted = input.trim().split('').map((char) {
      const myanmar = '၀၁၂၃၄၅၆၇၈၉';
      const latin = '0123456789';
      final index = myanmar.indexOf(char);
      return index >= 0 ? latin[index] : char;
    }).join();
    return converted.isEmpty ? null : converted;
  }
}

const _uuid = Uuid();
