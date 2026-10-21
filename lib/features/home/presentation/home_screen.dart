import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/copy.dart';
import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';

class HomeDestination {
  const HomeDestination({required this.label, required this.icon, required this.route, this.emphasis = false});

  final String label;
  final IconData icon;
  final String route;
  final bool emphasis;
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = AppCopy(english: ref.watch(settingsProvider).value?.english ?? false);
    final destinations = [
      HomeDestination(label: copy.sale, icon: Icons.shopping_cart_outlined, route: '/sale', emphasis: true),
      HomeDestination(label: copy.saleList, icon: Icons.receipt_long_outlined, route: '/sales'),
      HomeDestination(label: copy.purchases, icon: Icons.inventory_2_outlined, route: '/purchase'),
      HomeDestination(label: copy.products, icon: Icons.widgets_outlined, route: '/products'),
      HomeDestination(label: copy.prices, icon: Icons.sell_outlined, route: '/selling-prices'),
      HomeDestination(label: copy.categories, icon: Icons.grid_view_rounded, route: '/categories'),
      HomeDestination(label: copy.damage, icon: Icons.heart_broken_outlined, route: '/damage'),
      HomeDestination(label: copy.expenses, icon: Icons.account_balance_wallet_outlined, route: '/expense'),
      HomeDestination(label: copy.stock, icon: Icons.table_rows_outlined, route: '/stock'),
      HomeDestination(label: copy.stockReport, icon: Icons.description_outlined, route: '/stock-report'),
      HomeDestination(label: copy.daily, icon: Icons.bar_chart, route: '/profit'),
      HomeDestination(label: copy.accounts, icon: Icons.manage_accounts_outlined, route: '/accounts'),
      HomeDestination(label: copy.settings, icon: Icons.settings_outlined, route: '/settings'),
    ];
    final others = destinations.where((item) => !item.emphasis).toList();
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(copy.home, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(copy.choose, style: const TextStyle(color: KasaColors.muted)),
              const SizedBox(height: 20),
              _SaleTile(label: copy.sale, onTap: () => Navigator.of(context).pushNamed('/sale')),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: others.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 260,
                  mainAxisExtent: 96,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = others[index];
                  return _ModuleTile(item: item, onTap: () => Navigator.of(context).pushNamed(item.route));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaleTile extends StatelessWidget {
  const _SaleTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KasaColors.brown,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.item, required this.onTap});

  final HomeDestination item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(item.icon, color: KasaColors.brown),
              const SizedBox(width: 12),
              Expanded(child: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w500))),
              const Icon(Icons.chevron_right, color: KasaColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
