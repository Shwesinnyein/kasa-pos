import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../data/repurchase_local_data_source.dart';
import '../domain/entities/purchase_models.dart';
import 'repurchase_detail_screen.dart';

class RepurchaseListScreen extends ConsumerWidget {
  const RepurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(repurchaseListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: list.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('ပြန်ဝယ်စာရင်းဖွင့်မရပါ။')),
        data: (docs) => _body(context, ref, docs),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, List<RepurchaseDocument> docs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(child: Text('ပြန်ဝယ်စာရင်း', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
              FilledButton.icon(
                onPressed: () => _openCurrent(context, ref),
                style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                icon: const Icon(Icons.add),
                label: const Text('ပြန်ဝယ်အသစ်'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (docs.isNotEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  SizedBox(width: 110, child: Text('ရက်စွဲ', style: _header)),
                  Expanded(child: Text('ပြန်ဝယ်စာရင်း', style: _header)),
                  SizedBox(width: 140, child: Text('စုစုပေါင်း', textAlign: TextAlign.right, style: _header)),
                  SizedBox(width: 88, child: Text('အခြေအနေ', textAlign: TextAlign.right, style: _header)),
                  SizedBox(width: 88, child: Text('လုပ်ဆောင်ချက်', textAlign: TextAlign.right, style: _header)),
                ],
              ),
            ),
          Expanded(
            child: docs.isEmpty
                ? const Center(child: Text('ပြန်ဝယ်မရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                : ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      return Material(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => _open(context, ref, doc.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                SizedBox(width: 110, child: Text(_day(doc.createdAt))),
                                Expanded(
                                  child: Text(repurchaseListLabel(doc.repurchaseNo), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Text(doc.total == null ? '' : '${money(doc.total!)} ကျပ်', textAlign: TextAlign.right),
                                ),
                                SizedBox(
                                  width: 88,
                                  child: Text(
                                    doc.completed ? 'ပြီး' : 'ဖွင့်ထား',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: doc.completed ? KasaColors.muted : KasaColors.brown, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 88,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      style: _actionButton,
                                      onPressed: () => _open(context, ref, doc.id),
                                      child: const Text('ကြည့်မည်'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _openCurrent(BuildContext context, WidgetRef ref) async {
    final id = await RepurchaseLocalDataSource(ref.read(databaseProvider)).ensureOpen();
    ref.invalidate(repurchaseListProvider);
    if (!context.mounted) return;
    await _open(context, ref, id);
  }

  Future<void> _open(BuildContext context, WidgetRef ref, String id) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => RepurchaseDetailScreen(repurchaseId: id)));
    ref.invalidate(repurchaseListProvider);
  }
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

const _actionButton = ButtonStyle(
  visualDensity: VisualDensity.compact,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  minimumSize: WidgetStatePropertyAll(Size(0, 32)),
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 6)),
);

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
