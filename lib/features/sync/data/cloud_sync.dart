import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';

class CloudConfig {
  const CloudConfig({required this.url, required this.key});

  final String url;
  final String key;

  static const empty = CloudConfig(url: '', key: '');

  bool get ready => url.trim().isNotEmpty && key.trim().isNotEmpty;
}

class CloudSync {
  CloudSync(this._db, {required this.onDone});

  final AppDatabase _db;
  final void Function() onDone;

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
    final config = CloudConfig(url: device?.supabaseUrl ?? '', key: device?.supabaseKey ?? '');
    if (!config.ready) return 'missing';
    final base = _baseUrl(config.url);
    if (base == null) return 'url';
    if (config.key.trim().startsWith('sb_secret_')) return 'secret';

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
