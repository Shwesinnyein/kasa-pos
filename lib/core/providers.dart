import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';
import '../features/auth/data/datasources/auth_local_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/sign_in_with_pin.dart';
import '../features/categories/data/category_local_data_source.dart';
import '../features/damage/data/damage_local_data_source.dart';
import '../features/expenses/data/expense_local_data_source.dart';
import '../features/profit/data/profit_local_data_source.dart';
import '../features/categories/domain/entities/category_item.dart';
import '../features/products/data/product_local_data_source.dart';
import '../features/purchases/data/purchase_local_data_source.dart';
import '../features/purchases/data/repurchase_local_data_source.dart';
import '../features/purchases/domain/entities/purchase_models.dart';
import '../features/products/domain/entities/product_list_item.dart';
import '../features/sale/data/sale_local_data_source.dart';
import '../features/sale/data/sale_repository_impl.dart';
import '../features/sale/domain/entities/sale_catalog.dart';
import '../features/sale/domain/entities/sale_record.dart';
import '../features/sale/domain/repositories/sale_repository.dart';
import '../features/settings/data/settings_local_data_source.dart';
import '../features/account/data/account_local_data_source.dart';
import '../features/shop/data/shop_local_data_source.dart';
import '../features/shop/domain/entities/shop_profile.dart';
import '../features/sync/data/cloud_sync.dart';
import '../features/sync/data/sync_local_data_source.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw StateError('databaseProvider must be overridden in main');
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(AuthLocalDataSource(ref.watch(databaseProvider)));
});

final signInWithPinProvider = Provider<SignInWithPin>((ref) {
  return SignInWithPin(ref.watch(authRepositoryProvider));
});

final shopProfileProvider = FutureProvider<ShopProfile>((ref) {
  return ShopLocalDataSource(ref.watch(databaseProvider)).load();
});

final accountListProvider = FutureProvider<List<AccountUser>>((ref) {
  return AccountLocalDataSource(ref.watch(databaseProvider)).load();
});

final settingsProvider = AsyncNotifierProvider<SettingsController, AppSettings>(SettingsController.new);

class SettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return SettingsLocalDataSource(ref.watch(databaseProvider)).load();
  }

  Future<void> save(AppSettings settings) async {
    await SettingsLocalDataSource(ref.read(databaseProvider)).save(settings);
    state = AsyncData(settings);
  }
}

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  return SaleRepositoryImpl(SaleLocalDataSource(ref.watch(databaseProvider)));
});

final saleCatalogProvider = FutureProvider<SaleCatalog>((ref) {
  return ref.watch(saleRepositoryProvider).loadCatalog();
});

final saleListProvider = FutureProvider<List<SaleSummary>>((ref) {
  return SaleLocalDataSource(ref.watch(databaseProvider)).loadList();
});

final saleDetailProvider = FutureProvider.family<SaleRecord?, String>((ref, id) {
  return SaleLocalDataSource(ref.watch(databaseProvider)).loadDetail(id);
});

final productListProvider = FutureProvider<List<ProductListItem>>((ref) {
  return ProductLocalDataSource(ref.watch(databaseProvider)).load();
});

final categoryListProvider = FutureProvider<List<CategoryItem>>((ref) {
  return CategoryLocalDataSource(ref.watch(databaseProvider)).load();
});

final purchaseListProvider = FutureProvider<List<PurchaseSummary>>((ref) {
  return PurchaseLocalDataSource(ref.watch(databaseProvider)).loadList();
});

final purchasePriceHistoryProvider = FutureProvider.family<List<PurchasePriceChange>, String>((ref, productId) {
  return PurchaseLocalDataSource(ref.watch(databaseProvider)).loadPriceHistory(productId);
});

final repurchaseListProvider = FutureProvider<List<RepurchaseDocument>>((ref) {
  return RepurchaseLocalDataSource(ref.watch(databaseProvider)).loadList();
});

final repurchaseSheetProvider = FutureProvider.family<RepurchaseSheet?, String>((ref, id) {
  return RepurchaseLocalDataSource(ref.watch(databaseProvider)).loadSheet(id);
});

final damageListProvider = FutureProvider<List<DamageSummary>>((ref) {
  return DamageLocalDataSource(ref.watch(databaseProvider)).loadList();
});

final expenseListProvider = FutureProvider<List<ExpenseItem>>((ref) {
  return ExpenseLocalDataSource(ref.watch(databaseProvider)).loadList();
});

final expenseCategoryProvider = FutureProvider<List<ExpenseCategoryOption>>((ref) {
  return ExpenseLocalDataSource(ref.watch(databaseProvider)).loadCategories();
});

final profitReportProvider = FutureProvider<ProfitReport>((ref) {
  return ProfitLocalDataSource(ref.watch(databaseProvider)).load();
});

final pendingCountProvider = FutureProvider<int>((ref) {
  return SyncLocalDataSource(ref.watch(databaseProvider)).pendingCount();
});

final cloudSyncProvider = Provider<CloudSync>((ref) {
  return CloudSync(ref.watch(databaseProvider), onDone: () => ref.invalidate(pendingCountProvider));
});

final onlineProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  yield _isOnline(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(_isOnline);
});

bool _isOnline(List<ConnectivityResult> results) {
  return results.any((result) => result != ConnectivityResult.none);
}
