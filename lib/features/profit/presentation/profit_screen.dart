import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';

class ProfitScreen extends ConsumerWidget {
  const ProfitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(profitReportProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: report.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('နေ့စဉ်စာရင်းဖွင့်မရပါ။')),
        data: (item) => ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            const Text('နေ့စဉ်စာရင်း', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('ရောင်းရငွေမှ အရင်းနှင့် အသုံးစရိတ်ကို နုတ်ထားသည်။', style: TextStyle(color: KasaColors.muted)),
            const SizedBox(height: 16),
            _Block(
              title: 'ယနေ့',
              sales: item.todaySales,
              cost: item.todayCost,
              expenses: item.todayExpenses,
              net: item.todayNet,
            ),
            const SizedBox(height: 12),
            _Block(
              title: 'စုစုပေါင်း',
              sales: item.allSales,
              cost: item.allCost,
              expenses: item.allExpenses,
              net: item.allNet,
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 110, child: Text('ရက်စွဲ', style: _header)),
                Expanded(child: Text('ရောင်းရငွေ', textAlign: TextAlign.right, style: _header)),
                Expanded(child: Text('အရင်း', textAlign: TextAlign.right, style: _header)),
                Expanded(child: Text('အသုံးစရိတ်', textAlign: TextAlign.right, style: _header)),
                Expanded(child: Text('အမြတ်', textAlign: TextAlign.right, style: _header)),
              ],
            ),
            const SizedBox(height: 8),
            if (item.days.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: Text('မှတ်တမ်းမရှိသေးပါ။', style: TextStyle(color: KasaColors.muted))),
              )
            else
              for (final day in item.days) ...[
                Material(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        SizedBox(width: 94, child: Text(_day(day.day), style: const TextStyle(fontWeight: FontWeight.w700))),
                        Expanded(child: Text('${money(day.sales)} ကျပ်', textAlign: TextAlign.right)),
                        Expanded(child: Text('${money(day.cost)} ကျပ်', textAlign: TextAlign.right)),
                        Expanded(child: Text('${money(day.expenses)} ကျပ်', textAlign: TextAlign.right)),
                        Expanded(child: Text('${money(day.net)} ကျပ်', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w700, color: KasaColors.brown))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.sales, required this.cost, required this.expenses, required this.net});

  final String title;
  final double sales;
  final double cost;
  final double expenses;
  final double net;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            _line('ရောင်းရငွေ', sales),
            _line('အရင်း', cost),
            _line('အသုံးစရိတ်', expenses),
            const Divider(),
            _line('အမြတ်', net, strong: true),
          ],
        ),
      ),
    );
  }

  Widget _line(String label, double amount, {bool strong = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: strong ? FontWeight.w700 : FontWeight.w500))),
          Text('${money(amount)} ကျပ်', style: TextStyle(fontWeight: FontWeight.w700, fontSize: strong ? 20 : 16, color: strong ? KasaColors.brown : KasaColors.ink)),
        ],
      ),
    );
  }
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
