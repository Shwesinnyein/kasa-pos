import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../purchases/domain/entities/purchase_models.dart';

class PurchasePriceHistoryScreen extends ConsumerWidget {
  const PurchasePriceHistoryScreen({super.key, required this.productId, required this.nameMm, required this.unitMm});

  final String productId;
  final String nameMm;
  final String unitMm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(purchasePriceHistoryProvider(productId));
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အဝယ်ဈေးဖွင့်မရပါ။')),
        data: (items) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(nameMm, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('အဝယ်ရက်နှင့် ဈေး။ နောက်အဝယ်ကို ယခင်အဝယ်နှင့် နှိုင်းသည်။', style: TextStyle(color: KasaColors.muted)),
              const SizedBox(height: 16),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text('အဝယ်မရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) => _PriceRow(item: items[index], unitMm: unitMm),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.item, required this.unitMm});

  final PurchasePriceChange item;
  final String unitMm;

  @override
  Widget build(BuildContext context) {
    final pack = item.packSize > 1;
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_day(item.purchasedAt)),
                  Text(purchaseListLabel(item.purchaseNo), style: const TextStyle(color: KasaColors.muted, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pack ? '${money(item.paid)} ကျပ် / ဖာ' : '${money(item.paid)} ကျပ် / $unitMm',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  if (pack) Text('တစ်ခုလျှင် ${money(item.each)} ကျပ်', style: const TextStyle(color: KasaColors.muted, fontSize: 12)),
                ],
              ),
            ),
            Text(_moveLabel(item.move), style: TextStyle(color: _moveColor(item.move), fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';

String _moveLabel(PriceMove move) => switch (move) {
      PriceMove.first => 'ပထမ',
      PriceMove.up => 'တက်',
      PriceMove.down => 'ကျ',
      PriceMove.same => 'မပြောင်း',
    };

Color _moveColor(PriceMove move) => switch (move) {
      PriceMove.up => KasaColors.danger,
      PriceMove.down => KasaColors.online,
      PriceMove.first || PriceMove.same => KasaColors.muted,
    };
