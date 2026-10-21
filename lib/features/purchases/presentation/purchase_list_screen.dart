import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../domain/entities/purchase_models.dart';
import 'purchase_form_screen.dart';
import 'repurchase_list_screen.dart';

class PurchaseListScreen extends ConsumerWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchases = ref.watch(purchaseListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: purchases.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အဝယ်ဖွင့်မရပါ။')),
        data: (items) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  const Expanded(child: Text('အဝယ်', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const RepurchaseListScreen())),
                    style: OutlinedButton.styleFrom(foregroundColor: KasaColors.ink, side: const BorderSide(color: KasaColors.line)),
                    child: const Text('ပြန်ဝယ်စာရင်း'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const PurchaseFormScreen())),
                    style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                    icon: const Icon(Icons.add),
                    label: const Text('အဝယ်အသစ်'),
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
                    Expanded(child: Text('အဝယ်စာရင်း', style: _header)),
                    SizedBox(width: 140, child: Text('စုစုပေါင်း', textAlign: TextAlign.right, style: _header)),
                    SizedBox(width: _statusWidth, child: Text('အခြေအနေ', textAlign: TextAlign.right, style: _header)),
                    SizedBox(width: _actionWidth, child: Text('လုပ်ဆောင်ချက်', textAlign: TextAlign.right, style: _header)),
                  ],
                ),
              ),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('အဝယ်မရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _PurchaseRow(
                          item: item,
                          onView: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (_) => PurchaseFormScreen(purchaseId: item.id)),
                          ),
                          onEdit: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (_) => PurchaseFormScreen(purchaseId: item.id, editing: true)),
                          ),
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

class _PurchaseRow extends StatelessWidget {
  const _PurchaseRow({required this.item, required this.onView, required this.onEdit});

  final PurchaseSummary item;
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
              SizedBox(width: 110, child: Text(_day(item.purchasedAt))),
              Expanded(child: Text(purchaseListLabel(item.purchaseNo), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
              SizedBox(width: 140, child: Text('${money(item.total)} ကျပ်', textAlign: TextAlign.right)),
              SizedBox(
                width: _statusWidth,
                child: item.pending
                    ? Text('မပို့ရသေး', textAlign: TextAlign.right, style: TextStyle(color: KasaColors.brown, fontSize: 12, fontWeight: FontWeight.w600))
                    : const SizedBox.shrink(),
              ),
              SizedBox(width: _actionWidth, child: _Actions(onView: onView, onEdit: onEdit)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.onView, required this.onEdit});

  final VoidCallback onView;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(style: _actionButton, onPressed: onView, child: const Text('ကြည့်မည်')),
        TextButton(style: _actionButton, onPressed: onEdit, child: const Text('ပြင်မည်')),
      ],
    );
  }
}

const _statusWidth = 108.0;
const _actionWidth = 156.0;

const _actionButton = ButtonStyle(
  visualDensity: VisualDensity.compact,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: WidgetStatePropertyAll(Size(0, 32)),
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 6)),
);

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
