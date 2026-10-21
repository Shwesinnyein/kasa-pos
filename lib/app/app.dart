import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/sign_in_screen.dart';
import '../features/categories/presentation/category_list_screen.dart';
import '../features/damage/presentation/damage_list_screen.dart';
import '../features/expenses/presentation/expense_list_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/account/presentation/account_list_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/settings/data/settings_local_data_source.dart';
import '../core/providers.dart';
import '../features/profit/presentation/profit_screen.dart';
import '../features/purchases/presentation/purchase_list_screen.dart';
import '../features/prices/presentation/selling_price_screen.dart';
import '../features/products/presentation/product_list_screen.dart';
import '../features/sale/presentation/sale_list_screen.dart';
import '../features/sale/presentation/sale_screen.dart';
import '../features/stock/presentation/stock_list_screen.dart';
import '../features/stock/presentation/stock_report_screen.dart';
import '../features/session/session_controller.dart';
import 'theme.dart';

class KasaApp extends ConsumerWidget {
  const KasaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final signedOut = session == null;
    final settings = ref.watch(settingsProvider).value ?? AppSettings.fallback;

    return MaterialApp(
      title: 'Kasa Shop',
      debugShowCheckedModeBanner: false,
      theme: buildKasaTheme(seed: settings.color),
      darkTheme: buildKasaTheme(seed: settings.color, brightness: Brightness.dark),
      themeMode: settings.mode,
      home: signedOut
          ? const SignInScreen()
          : session.isOwner
              ? const HomeScreen()
              : const SaleScreen(),
      routes: {
        '/sale': (_) => const SaleScreen(),
        '/sales': (_) => const SaleListScreen(),
        '/purchase': (_) => const PurchaseListScreen(),
        '/damage': (_) => const DamageListScreen(),
        '/expense': (_) => const ExpenseListScreen(),
        '/products': (_) => const ProductListScreen(),
        '/selling-prices': (_) => const SellingPriceScreen(),
        '/categories': (_) => const CategoryListScreen(),
        '/stock': (_) => const StockListScreen(),
        '/stock-report': (_) => const StockReportScreen(),
        '/profit': (_) => const ProfitScreen(),
        '/accounts': (_) => const AccountListScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/cloud': (_) => const CloudSyncScreen(),
      },
    );
  }
}
