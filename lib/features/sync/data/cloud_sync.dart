import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import 'web_save.dart';

class CloudConfig {
  const CloudConfig({required this.url, required this.key});

  final String url;
  final String key;

  static const builtInUrl = 'https://mmqkaqewcbhzeflefgiq.supabase.co';
  static const builtInKey = 'sb_publishable_P0NLYwHZ-3l1fCrrJnXq1w_lU1aIU41';

  static const empty = CloudConfig(url: builtInUrl, key: builtInKey);

  factory CloudConfig.saved({String? url, String? key}) {
    final savedUrl = (url ?? '').trim();
    final savedKey = (key ?? '').trim();
    return CloudConfig(
      url: savedUrl.isEmpty ? builtInUrl : savedUrl,
      key: savedKey.isEmpty ? builtInKey : savedKey,
    );
  }

  bool get ready => url.trim().isNotEmpty && key.trim().isNotEmpty && !key.trim().startsWith('sb_secret_');
}

class CloudSync {
  CloudSync(this._db, {required this.onDone, this.hub});

  final AppDatabase _db;
  final void Function() onDone;
  final WebSaveHub? hub;

  var _again = false;
  Future<String?>? _current;

  Future<String?> push() {
    if (_current != null) {
      _again = true;
      return _current!;
    }
    final run = _run();
    _current = run;
    return run.whenComplete(() {
      if (identical(_current, run)) _current = null;
    });
  }

  Future<String?> _run() async {
    String? error;
    do {
      _again = false;
      error = await _pushOnce();
      if (error == null) onDone();
    } while (_again && error == null);
    return error;
  }

  Future<String?> _pushOnce() async {
    final device = await (_db.select(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).getSingleOrNull();
    final config = CloudConfig.saved(url: device?.supabaseUrl, key: device?.supabaseKey);
    if (!config.ready) return 'missing';
    final base = _baseUrl(config.url);
    if (base == null) return 'url';
    if (config.key.trim().startsWith('sb_secret_')) return 'secret';

    hub?.paused = true;
    try {
      try {
        await _deleteRemovedStaff(base, config.key);
        await _pull(base, config.key);
      } on CloudSyncException catch (error) {
        return error.message;
      }

    final shops = await _db.select(_db.shops).get();
    final staff = await _db.select(_db.staff).get();
    final categories = await _db.select(_db.categories).get();
    final units = await _db.select(_db.units).get();
    final products = await _db.select(_db.products).get();
    final suppliers = await _db.select(_db.suppliers).get();
    final expenseCategories = await _db.select(_db.expenseCategories).get();
    final purchases = await _db.select(_db.purchases).get();
    final purchaseLines = await _db.select(_db.purchaseLines).get();
    final sales = await _db.select(_db.sales).get();
    final saleLines = await _db.select(_db.saleLines).get();
    final damages = await _db.select(_db.damages).get();
    final damageLines = await _db.select(_db.damageLines).get();
    final expenses = await _db.select(_db.expenses).get();
    final repurchases = await _db.select(_db.repurchases).get();
    final repurchaseItems = await _db.select(_db.repurchaseItems).get();
    final movements = await _db.select(_db.stockMovements).get();
    final reports = await _db.select(_db.developerReports).get();

    final sentAt = DateTime.now().toUtc();
    try {
      await _upsert(base, config.key, 'shops', [
        for (final row in shops)
          {
            'id': row.id,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'receipt_language': row.receiptLanguage,
            'currency': row.currency,
            'created_at': _time(row.createdAt),
          },
      ]);
      await _upsert(base, config.key, 'staff', [
        for (final row in staff)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'name': row.name,
            'role': row.role,
            'pin_hash': row.pinHash,
            'is_active': row.isActive,
          },
      ]);
      await _upsert(base, config.key, 'categories', [
        for (final row in categories)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'parent_id': row.parentId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'sort_order': row.sortOrder,
            'is_active': row.isActive,
            'device_id': row.deviceId,
            'sync_status': 'synced',
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'units', [
        for (final row in units)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'sync_status': 'synced',
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'products', [
        for (final row in products)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'category_id': row.categoryId,
            'unit_id': row.unitId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'barcode': row.barcode,
            'sku': row.sku,
            'cost': row.cost,
            'price': row.price,
            'pack_size': row.packSize,
            'pack_price': row.packPrice,
            'buy_price': row.buyPrice,
            'pack_buy_price': row.packBuyPrice,
            'previous_price': row.previousPrice,
            'previous_pack_price': row.previousPackPrice,
            'reorder_level': row.reorderLevel,
            'is_active': row.isActive,
            'device_id': row.deviceId,
            'sync_status': 'synced',
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'suppliers', [
        for (final row in suppliers)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'phone': row.phone,
            'note': row.note,
            'sync_status': 'synced',
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'expense_categories', [
        for (final row in expenseCategories)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'sync_status': 'synced',
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'purchases', [
        for (final row in purchases)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'device_id': row.deviceId,
            'supplier_id': row.supplierId,
            'staff_id': row.staffId,
            'purchase_no': row.purchaseNo,
            'purchased_at': _time(row.purchasedAt),
            'total': row.total,
            'note': row.note,
            'sync_status': 'synced',
            'created_at': _time(row.createdAt),
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'purchase_lines', [
        for (final row in purchaseLines)
          {
            'id': row.id,
            'purchase_id': row.purchaseId,
            'product_id': row.productId,
            'qty': row.qty,
            'unit_cost': row.unitCost,
            'line_total': row.lineTotal,
            'pack_size': row.packSize,
          },
      ]);
      await _upsert(base, config.key, 'sales', [
        for (final row in sales)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'device_id': row.deviceId,
            'staff_id': row.staffId,
            'sale_no': row.saleNo,
            'sold_at': _time(row.soldAt),
            'subtotal': row.subtotal,
            'discount': row.discount,
            'total': row.total,
            'paid_amount': row.paidAmount,
            'payment_method': row.paymentMethod,
            'sync_status': 'synced',
            'created_at': _time(row.createdAt),
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'sale_lines', [
        for (final row in saleLines)
          {
            'id': row.id,
            'sale_id': row.saleId,
            'product_id': row.productId,
            'name_en': row.nameEn,
            'name_mm': row.nameMm,
            'qty': row.qty,
            'unit_price': row.unitPrice,
            'unit_cost': row.unitCost,
            'line_total': row.lineTotal,
            'line_cost': row.lineCost,
            'pack_size': row.packSize,
          },
      ]);
      await _upsert(base, config.key, 'damages', [
        for (final row in damages)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'device_id': row.deviceId,
            'staff_id': row.staffId,
            'damage_no': row.damageNo,
            'damaged_at': _time(row.damagedAt),
            'note': row.note,
            'sync_status': 'synced',
            'created_at': _time(row.createdAt),
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'damage_lines', [
        for (final row in damageLines)
          {
            'id': row.id,
            'damage_id': row.damageId,
            'product_id': row.productId,
            'qty': row.qty,
            'unit_cost': row.unitCost,
            'line_cost': row.lineCost,
            'reason': row.reason,
          },
      ]);
      await _upsert(base, config.key, 'expenses', [
        for (final row in expenses)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'device_id': row.deviceId,
            'staff_id': row.staffId,
            'expense_category_id': row.expenseCategoryId,
            'title': row.title,
            'amount': row.amount,
            'spent_at': _time(row.spentAt),
            'note': row.note,
            'sync_status': 'synced',
            'created_at': _time(row.createdAt),
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'repurchases', [
        for (final row in repurchases)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'repurchase_no': row.repurchaseNo,
            'status': row.status,
            'purchase_id': row.purchaseId,
            'created_at': _time(row.createdAt),
            'updated_at': _time(row.updatedAt),
          },
      ]);
      await _upsert(base, config.key, 'repurchase_items', [
        for (final row in repurchaseItems)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'repurchase_id': row.repurchaseId,
            'product_id': row.productId,
            'qty': row.qty,
            'pack_qty': row.packQty,
            'pack_size': row.packSize,
            'created_at': _time(row.createdAt),
          },
      ]);
      await _upsert(base, config.key, 'stock_movements', [
        for (final row in movements)
          {
            'id': row.id,
            'shop_id': row.shopId,
            'product_id': row.productId,
            'source_type': row.sourceType,
            'source_id': row.sourceId,
            'qty_change': row.qtyChange,
            'unit_cost': row.unitCost,
            'happened_at': _time(row.happenedAt),
          },
      ]);
      await _upsert(base, config.key, 'developer_reports', [
        for (final row in reports)
          {
            'id': row.id,
            'message': row.message,
            'created_at': _time(row.createdAt),
          },
      ]);
      await _upsert(base, config.key, 'devices', [
        if (device != null)
          {
            'id': device.id,
            'shop_id': device.shopId,
            'name': device.name,
            'platform': device.platform,
            'language': device.language,
            'theme_mode': device.themeMode,
            'theme_color': device.themeColor,
            'last_sync_at': _time(sentAt),
          },
      ]);
    } on CloudSyncException catch (error) {
      return error.message;
    }

    await _markSynced();
    await (_db.update(_db.devices)..where((row) => row.id.equals(DatabaseSeeder.deviceId))).write(
      DevicesCompanion(lastSyncAt: Value(sentAt)),
    );
    return null;
    } finally {
      hub?.paused = false;
    }
  }

  Future<void> _pull(String base, String key) async {
    final pendingSales = {for (final row in await (_db.select(_db.sales)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingPurchases = {for (final row in await (_db.select(_db.purchases)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingDamages = {for (final row in await (_db.select(_db.damages)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingExpenses = {for (final row in await (_db.select(_db.expenses)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingProducts = {for (final row in await (_db.select(_db.products)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingCategories = {for (final row in await (_db.select(_db.categories)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingUnits = {for (final row in await (_db.select(_db.units)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingSuppliers = {for (final row in await (_db.select(_db.suppliers)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};
    final pendingExpenseCategories = {for (final row in await (_db.select(_db.expenseCategories)..where((row) => row.syncStatus.equals('pending'))).get()) row.id};

    for (final row in await _fetch(base, key, 'shops')) {
      await _db.into(_db.shops).insertOnConflictUpdate(
            ShopsCompanion.insert(
              id: row['id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              receiptLanguage: Value((row['receipt_language'] as String?) ?? 'my'),
              currency: Value((row['currency'] as String?) ?? 'MMK'),
              createdAt: _date(row['created_at']),
            ),
          );
    }
    final removedStaff = {for (final row in await _db.select(_db.staffDeletions).get()) row.id};
    final remoteStaff = <String>{};
    for (final row in await _fetch(base, key, 'staff')) {
      final id = row['id'] as String;
      remoteStaff.add(id);
      if (removedStaff.contains(id)) continue;
      await _db.into(_db.staff).insertOnConflictUpdate(
            StaffCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              name: row['name'] as String,
              role: row['role'] as String,
              pinHash: row['pin_hash'] as String,
              isActive: Value(row['is_active'] as bool? ?? true),
              syncStatus: const Value('synced'),
            ),
          );
    }
    final localStaff = await _db.select(_db.staff).get();
    for (final row in localStaff) {
      final gone = removedStaff.contains(row.id) || (row.syncStatus == 'synced' && !remoteStaff.contains(row.id));
      if (!gone) continue;
      await (_db.delete(_db.staff)..where((item) => item.id.equals(row.id))).go();
    }
    for (final row in await _fetch(base, key, 'categories')) {
      final id = row['id'] as String;
      if (pendingCategories.contains(id)) continue;
      await _db.into(_db.categories).insertOnConflictUpdate(
            CategoriesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              parentId: Value(row['parent_id'] as String?),
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              sortOrder: Value(_int(row['sort_order'])),
              isActive: Value(row['is_active'] as bool? ?? true),
              deviceId: Value(row['device_id'] as String?),
              syncStatus: const Value('synced'),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'units')) {
      final id = row['id'] as String;
      if (pendingUnits.contains(id)) continue;
      await _db.into(_db.units).insertOnConflictUpdate(
            UnitsCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              syncStatus: const Value('synced'),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'products')) {
      final id = row['id'] as String;
      if (pendingProducts.contains(id)) continue;
      await _db.into(_db.products).insertOnConflictUpdate(
            ProductsCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              categoryId: row['category_id'] as String,
              unitId: row['unit_id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              barcode: Value(row['barcode'] as String?),
              sku: Value(row['sku'] as String?),
              cost: Value(_double(row['cost'])),
              price: _double(row['price']),
              packSize: Value(_doubleOrNull(row['pack_size'])),
              packPrice: Value(_doubleOrNull(row['pack_price'])),
              buyPrice: Value(_doubleOrNull(row['buy_price'])),
              packBuyPrice: Value(_doubleOrNull(row['pack_buy_price'])),
              previousPrice: Value(_doubleOrNull(row['previous_price'])),
              previousPackPrice: Value(_doubleOrNull(row['previous_pack_price'])),
              reorderLevel: Value(_doubleOrNull(row['reorder_level'])),
              isActive: Value(row['is_active'] as bool? ?? true),
              deviceId: Value(row['device_id'] as String?),
              syncStatus: const Value('synced'),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'suppliers')) {
      final id = row['id'] as String;
      if (pendingSuppliers.contains(id)) continue;
      await _db.into(_db.suppliers).insertOnConflictUpdate(
            SuppliersCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              phone: Value(row['phone'] as String?),
              note: Value(row['note'] as String?),
              syncStatus: const Value('synced'),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'expense_categories')) {
      final id = row['id'] as String;
      if (pendingExpenseCategories.contains(id)) continue;
      await _db.into(_db.expenseCategories).insertOnConflictUpdate(
            ExpenseCategoriesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              syncStatus: const Value('synced'),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'purchases')) {
      final id = row['id'] as String;
      if (pendingPurchases.contains(id)) continue;
      await _db.into(_db.purchases).insertOnConflictUpdate(
            PurchasesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              deviceId: row['device_id'] as String,
              supplierId: Value(row['supplier_id'] as String?),
              staffId: row['staff_id'] as String,
              purchaseNo: row['purchase_no'] as String,
              purchasedAt: _date(row['purchased_at']),
              total: _double(row['total']),
              note: Value(row['note'] as String?),
              syncStatus: const Value('synced'),
              createdAt: _date(row['created_at']),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'purchase_lines')) {
      if (pendingPurchases.contains(row['purchase_id'])) continue;
      await _db.into(_db.purchaseLines).insertOnConflictUpdate(
            PurchaseLinesCompanion.insert(
              id: row['id'] as String,
              purchaseId: row['purchase_id'] as String,
              productId: row['product_id'] as String,
              qty: _double(row['qty']),
              unitCost: _double(row['unit_cost']),
              lineTotal: _double(row['line_total']),
              packSize: Value(_double(row['pack_size'])),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'sales')) {
      final id = row['id'] as String;
      if (pendingSales.contains(id)) continue;
      await _db.into(_db.sales).insertOnConflictUpdate(
            SalesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              deviceId: row['device_id'] as String,
              staffId: row['staff_id'] as String,
              saleNo: row['sale_no'] as String,
              soldAt: _date(row['sold_at']),
              subtotal: _double(row['subtotal']),
              discount: Value(_double(row['discount'])),
              total: _double(row['total']),
              paidAmount: _double(row['paid_amount']),
              paymentMethod: row['payment_method'] as String,
              syncStatus: const Value('synced'),
              createdAt: _date(row['created_at']),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'sale_lines')) {
      if (pendingSales.contains(row['sale_id'])) continue;
      await _db.into(_db.saleLines).insertOnConflictUpdate(
            SaleLinesCompanion.insert(
              id: row['id'] as String,
              saleId: row['sale_id'] as String,
              productId: row['product_id'] as String,
              nameEn: Value(row['name_en'] as String?),
              nameMm: Value(row['name_mm'] as String?),
              qty: _double(row['qty']),
              unitPrice: _double(row['unit_price']),
              unitCost: _double(row['unit_cost']),
              lineTotal: _double(row['line_total']),
              lineCost: _double(row['line_cost']),
              packSize: Value(_double(row['pack_size'])),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'damages')) {
      final id = row['id'] as String;
      if (pendingDamages.contains(id)) continue;
      await _db.into(_db.damages).insertOnConflictUpdate(
            DamagesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              deviceId: row['device_id'] as String,
              staffId: row['staff_id'] as String,
              damageNo: row['damage_no'] as String,
              damagedAt: _date(row['damaged_at']),
              note: Value(row['note'] as String?),
              syncStatus: const Value('synced'),
              createdAt: _date(row['created_at']),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'damage_lines')) {
      if (pendingDamages.contains(row['damage_id'])) continue;
      await _db.into(_db.damageLines).insertOnConflictUpdate(
            DamageLinesCompanion.insert(
              id: row['id'] as String,
              damageId: row['damage_id'] as String,
              productId: row['product_id'] as String,
              qty: _double(row['qty']),
              unitCost: _double(row['unit_cost']),
              lineCost: _double(row['line_cost']),
              reason: row['reason'] as String,
            ),
          );
    }
    for (final row in await _fetch(base, key, 'expenses')) {
      final id = row['id'] as String;
      if (pendingExpenses.contains(id)) continue;
      await _db.into(_db.expenses).insertOnConflictUpdate(
            ExpensesCompanion.insert(
              id: id,
              shopId: row['shop_id'] as String,
              deviceId: row['device_id'] as String,
              staffId: row['staff_id'] as String,
              expenseCategoryId: row['expense_category_id'] as String,
              title: row['title'] as String,
              amount: _double(row['amount']),
              spentAt: _date(row['spent_at']),
              note: Value(row['note'] as String?),
              syncStatus: const Value('synced'),
              createdAt: _date(row['created_at']),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'repurchases')) {
      await _db.into(_db.repurchases).insertOnConflictUpdate(
            RepurchasesCompanion.insert(
              id: row['id'] as String,
              shopId: row['shop_id'] as String,
              repurchaseNo: row['repurchase_no'] as String,
              status: Value((row['status'] as String?) ?? 'open'),
              purchaseId: Value(row['purchase_id'] as String?),
              createdAt: _date(row['created_at']),
              updatedAt: _date(row['updated_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'repurchase_items')) {
      await _db.into(_db.repurchaseItems).insertOnConflictUpdate(
            RepurchaseItemsCompanion.insert(
              id: row['id'] as String,
              shopId: row['shop_id'] as String,
              repurchaseId: Value((row['repurchase_id'] as String?) ?? ''),
              productId: row['product_id'] as String,
              qty: Value(_double(row['qty'])),
              packQty: Value(_double(row['pack_qty'])),
              packSize: Value(_double(row['pack_size'])),
              createdAt: _date(row['created_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'stock_movements')) {
      await _db.into(_db.stockMovements).insertOnConflictUpdate(
            StockMovementsCompanion.insert(
              id: row['id'] as String,
              shopId: row['shop_id'] as String,
              productId: row['product_id'] as String,
              sourceType: row['source_type'] as String,
              sourceId: row['source_id'] as String,
              qtyChange: _double(row['qty_change']),
              unitCost: _double(row['unit_cost']),
              happenedAt: _date(row['happened_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'developer_reports')) {
      await _db.into(_db.developerReports).insertOnConflictUpdate(
            DeveloperReportsCompanion.insert(
              id: row['id'] as String,
              message: row['message'] as String,
              createdAt: _date(row['created_at']),
            ),
          );
    }
    for (final row in await _fetch(base, key, 'devices')) {
      await _db.into(_db.devices).insertOnConflictUpdate(
            DevicesCompanion(
              id: Value(row['id'] as String),
              shopId: Value(row['shop_id'] as String),
              name: Value(row['name'] as String),
              platform: Value(row['platform'] as String),
              language: Value((row['language'] as String?) ?? 'my'),
              themeMode: Value((row['theme_mode'] as String?) ?? 'system'),
              themeColor: Value((row['theme_color'] as String?) ?? 'brown'),
              lastSyncAt: Value(row['last_sync_at'] == null ? null : _date(row['last_sync_at'])),
            ),
          );
    }
  }

  Future<List<Map<String, dynamic>>> _fetch(String base, String key, String table) async {
    final response = await http.get(
      Uri.parse('$base/rest/v1/$table?select=*'),
      headers: {
        'apikey': key.trim(),
        'Authorization': 'Bearer ${key.trim()}',
        'Accept': 'application/json',
        'Range': '0-4999',
      },
    ).timeout(const Duration(seconds: 30));
    if (response.statusCode >= 300) {
      final body = response.body.length > 280 ? response.body.substring(0, 280) : response.body;
      throw CloudSyncException('$table ${response.statusCode}: $body');
    }
    final decoded = jsonDecode(response.body);
    if (decoded is! List) return [];
    return [for (final row in decoded) Map<String, dynamic>.from(row as Map)];
  }

  DateTime _date(Object? value) => DateTime.parse(value as String).toLocal();

  double _double(Object? value) {
    if (value is num) return value.toDouble();
    return double.parse('$value');
  }

  double? _doubleOrNull(Object? value) {
    if (value == null) return null;
    return _double(value);
  }

  int _int(Object? value) {
    if (value is num) return value.toInt();
    return int.parse('$value');
  }

  Future<void> _markSynced() async {
    const synced = Value('synced');
    await (_db.update(_db.categories)..where((row) => row.syncStatus.equals('pending'))).write(const CategoriesCompanion(syncStatus: synced));
    await (_db.update(_db.units)..where((row) => row.syncStatus.equals('pending'))).write(const UnitsCompanion(syncStatus: synced));
    await (_db.update(_db.products)..where((row) => row.syncStatus.equals('pending'))).write(const ProductsCompanion(syncStatus: synced));
    await (_db.update(_db.suppliers)..where((row) => row.syncStatus.equals('pending'))).write(const SuppliersCompanion(syncStatus: synced));
    await (_db.update(_db.purchases)..where((row) => row.syncStatus.equals('pending'))).write(const PurchasesCompanion(syncStatus: synced));
    await (_db.update(_db.sales)..where((row) => row.syncStatus.equals('pending'))).write(const SalesCompanion(syncStatus: synced));
    await (_db.update(_db.damages)..where((row) => row.syncStatus.equals('pending'))).write(const DamagesCompanion(syncStatus: synced));
    await (_db.update(_db.expenseCategories)..where((row) => row.syncStatus.equals('pending'))).write(const ExpenseCategoriesCompanion(syncStatus: synced));
    await (_db.update(_db.expenses)..where((row) => row.syncStatus.equals('pending'))).write(const ExpensesCompanion(syncStatus: synced));
    await (_db.update(_db.staff)..where((row) => row.syncStatus.equals('pending'))).write(const StaffCompanion(syncStatus: synced));
  }

  Future<void> _deleteRemovedStaff(String base, String key) async {
    final removed = await _db.select(_db.staffDeletions).get();
    for (final row in removed) {
      await _delete(base, key, 'staff', row.id);
    }
  }

  Future<void> _delete(String base, String key, String table, String id) async {
    final response = await http.delete(
      Uri.parse('$base/rest/v1/$table?id=eq.${Uri.encodeQueryComponent(id)}'),
      headers: {
        'apikey': key.trim(),
        'Authorization': 'Bearer ${key.trim()}',
        'Prefer': 'return=minimal',
      },
    ).timeout(const Duration(seconds: 30));
    if (response.statusCode >= 300) {
      final body = response.body.length > 280 ? response.body.substring(0, 280) : response.body;
      throw CloudSyncException('$table ${response.statusCode}: $body');
    }
  }

  Future<void> _upsert(String base, String key, String table, List<Map<String, Object?>> rows) async {
    for (var index = 0; index < rows.length; index += 200) {
      final end = index + 200 > rows.length ? rows.length : index + 200;
      final response = await http
          .post(
            Uri.parse('$base/rest/v1/$table'),
            headers: {
              'apikey': key.trim(),
              'Authorization': 'Bearer ${key.trim()}',
              'Content-Type': 'application/json',
              'Prefer': 'resolution=merge-duplicates,return=minimal',
            },
            body: jsonEncode(rows.sublist(index, end)),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode >= 300) {
        final body = response.body.length > 280 ? response.body.substring(0, 280) : response.body;
        throw CloudSyncException('$table ${response.statusCode}: $body');
      }
    }
  }

  String? _baseUrl(String raw) {
    var url = raw.trim();
    while (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    const rest = '/rest/v1';
    if (url.endsWith(rest)) url = url.substring(0, url.length - rest.length);
    if (!url.startsWith('https://')) return null;
    return url;
  }

  String _time(DateTime value) => value.toUtc().toIso8601String();
}

class CloudSyncException implements Exception {
  CloudSyncException(this.message);

  final String message;
}
