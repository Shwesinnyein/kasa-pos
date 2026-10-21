import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../domain/entities/sale_catalog.dart';
import '../domain/entities/sale_record.dart';
import '../domain/repositories/sale_repository.dart';
import '../domain/sale_math.dart';

class SaleLocalDataSource {
  SaleLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<SaleCatalog> loadCatalog() async {
    final categories = await (_db.select(_db.categories)..where((row) => row.isActive.equals(true))..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).get();
    final units = await _db.select(_db.units).get();
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    final products = await (_db.select(_db.products)..where((row) => row.isActive.equals(true))).get();

    return SaleCatalog(
      categories: [
        for (final category in categories)
          SaleCategory(id: category.id, nameMm: category.nameMm ?? category.nameEn ?? ''),
      ],
      products: [
        for (final product in products)
          if (product.price > 0)
          SaleProduct(
            id: product.id,
            categoryId: product.categoryId,
            nameMm: product.nameMm ?? product.nameEn ?? '',
            unitMm: unitName[product.unitId] ?? '',
            price: product.price,
            cost: product.cost,
            barcode: product.barcode,
            packPrice: product.packPrice,
            packSize: product.packSize,
            previousPrice: product.previousPrice,
            previousPackPrice: product.previousPackPrice,
          ),
      ],
    );
  }

  Future<String> save(NewSale sale) async {
    final now = DateTime.now();
    final saleId = _uuid.v4();
    final count = await _db.select(_db.sales).get();
    final saleNo = 'S${(count.length + 1).toString().padLeft(4, '0')}';
    final payment = switch (sale.payment) {
      PaymentMethod.cash => 'cash',
      PaymentMethod.card => 'card',
      PaymentMethod.transfer => 'transfer',
    };

    await _db.transaction(() async {
      await _db.into(_db.sales).insert(
            SalesCompanion.insert(
              id: saleId,
              shopId: DatabaseSeeder.shopId,
              deviceId: DatabaseSeeder.deviceId,
              staffId: sale.staffId,
              saleNo: saleNo,
              soldAt: now,
              subtotal: sale.subtotal,
              discount: Value(sale.discount),
              total: sale.total,
              paidAmount: sale.paidAmount,
              paymentMethod: payment,
              createdAt: now,
              updatedAt: now,
            ),
          );
      for (final line in sale.lines) {
        final lineId = _uuid.v4();
        await _db.into(_db.saleLines).insert(
              SaleLinesCompanion.insert(
                id: lineId,
                saleId: saleId,
                productId: line.productId,
                nameMm: Value(line.nameMm),
                qty: line.qty.toDouble(),
                unitPrice: line.unitPrice,
                unitCost: line.unitCost,
                lineTotal: line.unitPrice * line.qty,
                lineCost: line.unitCost * line.qty,
                packSize: Value(line.packSize),
              ),
            );
        await _db.into(_db.stockMovements).insert(
              StockMovementsCompanion.insert(
                id: _uuid.v4(),
                shopId: DatabaseSeeder.shopId,
                productId: line.productId,
                sourceType: 'sale',
                sourceId: lineId,
                qtyChange: -(line.qty * line.packSize),
                unitCost: line.packSize > 0 ? line.unitCost / line.packSize : line.unitCost,
                happenedAt: now,
              ),
            );
      }
    });
    return saleNo;
  }

  Future<List<SaleSummary>> loadList() async {
    final sales = await _db.select(_db.sales).get();
    final items = [
      for (final sale in sales) SaleSummary(id: sale.id, saleNo: sale.saleNo, soldAt: sale.soldAt, total: sale.total),
    ]..sort((a, b) => b.soldAt.compareTo(a.soldAt));
    return items;
  }

  Future<SaleRecord?> loadDetail(String id) async {
    final sale = await (_db.select(_db.sales)..where((row) => row.id.equals(id))).getSingleOrNull();
    if (sale == null) return null;
    final lines = await (_db.select(_db.saleLines)..where((row) => row.saleId.equals(id))).get();
    final products = await _db.select(_db.products).get();
    final units = await _db.select(_db.units).get();
    final productById = {for (final product in products) product.id: product};
    final unitName = {for (final unit in units) unit.id: unit.nameMm ?? ''};
    return SaleRecord(
      id: sale.id,
      saleNo: sale.saleNo,
      soldAt: sale.soldAt,
      subtotal: sale.subtotal,
      discount: sale.discount,
      total: sale.total,
      paidAmount: sale.paidAmount,
      payment: _payment(sale.paymentMethod),
      lines: [
        for (final line in lines)
          SaleLineRecord(
            productId: line.productId,
            nameMm: (line.nameMm != null && line.nameMm!.trim().isNotEmpty) ? line.nameMm!.trim() : (productById[line.productId]?.nameMm ?? ''),
            unitMm: unitName[productById[line.productId]?.unitId] ?? '',
            qty: line.qty,
            unitPrice: line.unitPrice,
            unitCost: line.unitCost,
            lineTotal: line.lineTotal,
            packSize: line.packSize,
          ),
      ],
    );
  }

  /// Rewrites the receipt and its stock movements. Stored selling price and cost on each kept line stay as they were.
  Future<String?> update(String saleId, SaleUpdate sale) async {
    final lines = sale.lines.where((line) => line.qty > 0).toList();
    if (lines.isEmpty) return 'ကုန်ပစ္စည်းတစ်ခုထည့်ပါ။';
    final now = DateTime.now();
    try {
      await _db.transaction(() async {
        final current = await (_db.select(_db.sales)..where((row) => row.id.equals(saleId))).getSingle();
        final oldLines = await (_db.select(_db.saleLines)..where((row) => row.saleId.equals(saleId))).get();
        for (final old in oldLines) {
          await (_db.delete(_db.stockMovements)..where((row) => row.sourceId.equals(old.id) & row.sourceType.equals('sale'))).go();
        }
        await (_db.delete(_db.saleLines)..where((row) => row.saleId.equals(saleId))).go();
        final subtotal = lines.fold<double>(0, (sum, line) => sum + line.unitPrice * line.qty);
        var discount = sale.discount;
        if (discount < 0) discount = 0;
        if (discount > subtotal) discount = subtotal;
        final total = subtotal - discount;
        final paid = sale.payment == PaymentMethod.cash ? sale.paidAmount : total;
        await (_db.update(_db.sales)..where((row) => row.id.equals(saleId))).write(
          SalesCompanion(
            subtotal: Value(subtotal),
            discount: Value(discount),
            total: Value(total),
            paidAmount: Value(paid),
            paymentMethod: Value(_paymentName(sale.payment)),
            syncStatus: const Value('pending'),
            updatedAt: Value(now),
          ),
        );
        for (final line in lines) {
          final lineId = _uuid.v4();
          final pack = line.packSize <= 0 ? 1.0 : line.packSize;
          await _db.into(_db.saleLines).insert(
                SaleLinesCompanion.insert(
                  id: lineId,
                  saleId: saleId,
                  productId: line.productId,
                  nameMm: Value(line.nameMm),
                  qty: line.qty.toDouble(),
                  unitPrice: line.unitPrice,
                  unitCost: line.unitCost,
                  lineTotal: line.unitPrice * line.qty,
                  lineCost: line.unitCost * line.qty,
                  packSize: Value(pack),
                ),
              );
          await _db.into(_db.stockMovements).insert(
                StockMovementsCompanion.insert(
                  id: _uuid.v4(),
                  shopId: DatabaseSeeder.shopId,
                  productId: line.productId,
                  sourceType: 'sale',
                  sourceId: lineId,
                  qtyChange: -(line.qty * pack),
                  unitCost: line.unitCost / pack,
                  happenedAt: current.soldAt,
                ),
              );
        }
      });
      return null;
    } catch (_) {
      return 'သိမ်းမရပါ။';
    }
  }
}

PaymentMethod _payment(String value) {
  return switch (value) {
    'card' => PaymentMethod.card,
    'transfer' => PaymentMethod.transfer,
    _ => PaymentMethod.cash,
  };
}

String _paymentName(PaymentMethod value) {
  return switch (value) {
    PaymentMethod.cash => 'cash',
    PaymentMethod.card => 'card',
    PaymentMethod.transfer => 'transfer',
  };
}
