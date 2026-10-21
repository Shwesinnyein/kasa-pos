import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Shops,
    Devices,
    Staff,
    Categories,
    Units,
    Products,
    Suppliers,
    Purchases,
    PurchaseLines,
    Sales,
    SaleLines,
    Damages,
    DamageLines,
    ExpenseCategories,
    Expenses,
    Repurchases,
    RepurchaseItems,
    StockMovements,
    DeveloperReports,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'kasa'));

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) => migrator.createAll(),
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(purchaseLines, purchaseLines.packSize);
            await migrator.addColumn(products, products.packSize);
          }
          if (from < 3) {
            await migrator.addColumn(products, products.packPrice);
            await migrator.addColumn(saleLines, saleLines.packSize);
          }
          if (from < 4) {
            await migrator.addColumn(products, products.buyPrice);
            await migrator.addColumn(products, products.packBuyPrice);
          }
          if (from < 5) {
            await migrator.createTable(repurchaseItems);
          }
          if (from < 6) {
            await migrator.addColumn(repurchaseItems, repurchaseItems.packQty);
            await customStatement('UPDATE repurchase_items SET pack_qty = qty, qty = 0 WHERE pack_size > 1');
          }
          if (from < 7) {
            await migrator.createTable(repurchases);
            await migrator.addColumn(repurchaseItems, repurchaseItems.repurchaseId);
            await customStatement(
              "INSERT INTO repurchases (id, shop_id, repurchase_no, status, created_at, updated_at) "
              "SELECT 'repurchase-migrated', shop_id, 'R0001', 'open', MIN(created_at), MIN(created_at) FROM repurchase_items GROUP BY shop_id",
            );
            await customStatement("UPDATE repurchase_items SET repurchase_id = 'repurchase-migrated' WHERE repurchase_id = ''");
          }
          if (from < 8) {
            await migrator.addColumn(products, products.previousPrice);
            await migrator.addColumn(products, products.previousPackPrice);
          }
          if (from < 9) {
            await migrator.addColumn(devices, devices.themeMode);
            await migrator.addColumn(devices, devices.themeColor);
            await migrator.createTable(developerReports);
          }
          if (from < 10) {
            await migrator.addColumn(devices, devices.supabaseUrl);
            await migrator.addColumn(devices, devices.supabaseKey);
          }
        },
      );
}
