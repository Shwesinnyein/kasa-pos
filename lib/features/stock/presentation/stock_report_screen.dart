import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../products/domain/entities/product_list_item.dart';

class StockReportScreen extends ConsumerStatefulWidget {
  const StockReportScreen({super.key});

  @override
  ConsumerState<StockReportScreen> createState() => _StockReportScreenState();
}

class _StockReportScreenState extends ConsumerState<StockReportScreen> {
  String? _categoryId;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final profit = ref.watch(profitReportProvider);
    final purchases = ref.watch(purchaseListProvider);
    final categories = ref.watch(categoryListProvider);
    if (products.isLoading || profit.isLoading || purchases.isLoading || categories.isLoading) {
      return const Scaffold(appBar: RegisterBar(showGear: true), body: Center(child: CircularProgressIndicator()));
    }
    if (products.hasError || profit.hasError || purchases.hasError || categories.hasError) {
      return const Scaffold(appBar: RegisterBar(showGear: true), body: Center(child: Text('လက်ကျန်အစီရင်ခံစာဖွင့်မရပါ။')));
    }
    final items = products.requireValue.where((item) => _categoryId == null || item.categoryId == _categoryId).toList();
    final categoryItems = [...categories.requireValue]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final report = profit.requireValue;
    final purchaseTotal = purchases.requireValue.fold<double>(0, (sum, item) => sum + item.total);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        children: [
          const Text('လက်ကျန်အစီရင်ခံစာ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('အမြတ်သည် ရောင်းရငွေမှ ရောင်းပြီးအရင်းနှင့် အသုံးစရိတ်ကို နုတ်ထားသည်။', style: TextStyle(color: KasaColors.muted)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _Card(label: 'အဝယ်စုစုပေါင်း', value: '${money(purchaseTotal)} ကျပ်')),
              const SizedBox(width: 12),
              Expanded(child: _Card(label: 'ရောင်းရငွေ', value: '${money(report.allSales)} ကျပ်')),
              const SizedBox(width: 12),
              Expanded(child: _Card(label: 'အမြတ်', value: '${money(report.allNet)} ကျပ်')),
              const SizedBox(width: 12),
              Expanded(child: _Card(label: 'အသုံးစရိတ်', value: '${money(report.allExpenses)} ကျပ်')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _Chip(label: 'အားလုံး', selected: _categoryId == null, onTap: () => setState(() => _categoryId = null)),
                for (final category in categoryItems)
                  _Chip(label: category.nameMm, selected: _categoryId == category.id, onTap: () => setState(() => _categoryId = category.id)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(flex: 3, child: Text('ကုန်ပစ္စည်း', style: _header)),
              Expanded(flex: 2, child: Text('လက်ကျန်', style: _header)),
              Expanded(flex: 2, child: Text('ရောင်းပြီး', style: _header)),
              Expanded(flex: 2, child: Text('အဝယ်ဈေး', textAlign: TextAlign.right, style: _header)),
              Expanded(flex: 2, child: Text('ရောင်းဈေး', textAlign: TextAlign.right, style: _header)),
              Expanded(flex: 2, child: Text('ရောင်းရငွေ', textAlign: TextAlign.right, style: _header)),
            ],
          ),
          const SizedBox(height: 8),
          if (items.isEmpty) const Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)),
          for (final item in items) ...[
            Material(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700))),
                    Expanded(flex: 2, child: Text('${_plain(item.stock)} ${item.unitMm}')),
                    Expanded(flex: 2, child: Text('${_plain(item.soldQty)} ${item.unitMm}')),
                    Expanded(flex: 2, child: Text('${money(_buy(item))} ကျပ်', textAlign: TextAlign.right)),
                    Expanded(flex: 2, child: Text('${money(item.price)} ကျပ်', textAlign: TextAlign.right)),
                    Expanded(flex: 2, child: Text('${money(item.soldAmount)} ကျပ်', textAlign: TextAlign.right)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

double _buy(ProductListItem item) {
  if (item.buyPrice != null && item.buyPrice! > 0) return item.buyPrice!;
  return item.cost;
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: KasaColors.brown,
        labelStyle: TextStyle(color: selected ? Colors.white : KasaColors.ink),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: KasaColors.muted)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);
