import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../domain/entities/sale_record.dart';
import 'sale_controller.dart';
import 'sale_detail_screen.dart';
import 'sale_screen.dart';

class SaleListScreen extends ConsumerWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(saleListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: sales.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အရောင်းဖွင့်မရပါ။')),
        data: (items) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  const Expanded(child: Text('အရောင်းစာရင်း', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  FilledButton.icon(
                    onPressed: () {
                      ref.read(saleControllerProvider.notifier).clearCart();
                      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SaleScreen()));
                    },
                    style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                    icon: const Icon(Icons.add),
                    label: const Text('အရောင်းအသစ်'),
                  ),
                ],
              ),
            ),
            if (items.isNotEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 8),
                child: Row(
                  children: [
                    SizedBox(width: 110, child: Text('ရက်စွဲ', style: _header)),
                    Expanded(child: Text('အရောင်း', style: _header)),
                    SizedBox(width: 160, child: Text('စုစုပေါင်း', textAlign: TextAlign.right, style: _header)),
                    SizedBox(width: _actionWidth, child: Text('လုပ်ဆောင်ချက်', textAlign: TextAlign.right, style: _header)),
                  ],
                ),
              ),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('အရောင်းမရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _SaleRow(
                          item: item,
                          onView: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => SaleDetailScreen(saleId: item.id))),
                          onEdit: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => SaleScreen(saleId: item.id))),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaleRow extends StatelessWidget {
  const _SaleRow({required this.item, required this.onView, required this.onEdit});

  final SaleSummary item;
  final VoidCallback onView;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onView,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              SizedBox(width: 110, child: Text(_day(item.soldAt))),
              Expanded(child: Text(saleListLabel(item.saleNo), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
              SizedBox(width: 160, child: Text('${money(item.total)} ကျပ်', textAlign: TextAlign.right)),
              SizedBox(
                width: _actionWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(style: _actionButton, onPressed: onView, child: const Text('ကြည့်မည်')),
                    TextButton(style: _actionButton, onPressed: onEdit, child: const Text('ပြင်မည်')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _actionWidth = 156.0;

const _actionButton = ButtonStyle(
  visualDensity: VisualDensity.compact,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: WidgetStatePropertyAll(Size(0, 32)),
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 6)),
);

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
