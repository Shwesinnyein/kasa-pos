import '../../../core/database/app_database.dart';

class SyncLocalDataSource {
  const SyncLocalDataSource(this._db);

  final AppDatabase _db;

  Future<int> pendingCount() async {
    final sales = await (_db.select(_db.sales)..where((row) => row.syncStatus.equals('pending'))).get();
    final purchases = await (_db.select(_db.purchases)..where((row) => row.syncStatus.equals('pending'))).get();
    final damages = await (_db.select(_db.damages)..where((row) => row.syncStatus.equals('pending'))).get();
    final expenses = await (_db.select(_db.expenses)..where((row) => row.syncStatus.equals('pending'))).get();
    final expenseCategories = await (_db.select(_db.expenseCategories)..where((row) => row.syncStatus.equals('pending'))).get();
    final products = await (_db.select(_db.products)..where((row) => row.syncStatus.equals('pending'))).get();
    final categories = await (_db.select(_db.categories)..where((row) => row.syncStatus.equals('pending'))).get();
    return sales.length + purchases.length + damages.length + expenses.length + expenseCategories.length + products.length + categories.length;
  }
}
