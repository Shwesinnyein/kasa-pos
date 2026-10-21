import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../data/damage_local_data_source.dart';
import 'damage_form_screen.dart';

class DamageListScreen extends ConsumerWidget {
  const DamageListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final damages = ref.watch(damageListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: damages.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('ပျက်စီးဖွင့်မရပါ။')),
        data: (items) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  const Expanded(child: Text('ပျက်စီး', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const DamageFormScreen())),
                    style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                    icon: const Icon(Icons.add),
                    label: const Text('ပျက်စီးအသစ်'),
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
                    Expanded(flex: 2, child: Text('ကုန်ပစ္စည်း', style: _header)),
                    Expanded(child: Text('အကြောင်းရင်း', style: _header)),
                    Expanded(child: Text('အရေအတွက်', style: _header)),
                    SizedBox(width: 120, child: Text('အရင်း', textAlign: TextAlign.right, style: _header)),
                    SizedBox(width: 88, child: Text('အခြေအနေ', textAlign: TextAlign.right, style: _header)),
                  ],
                ),
              ),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('ပျက်စီးမရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) => _Row(item: items[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.item});

  final DamageSummary item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 94,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_day(item.damagedAt)),
                  Text(item.damageNo, style: const TextStyle(color: KasaColors.muted, fontSize: 12)),
                ],
              ),
            ),
            Expanded(flex: 2, child: Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w700))),
            Expanded(child: Text(item.reason)),
            Expanded(child: Text('${_plain(item.qty)} ${item.unitMm}', style: const TextStyle(fontWeight: FontWeight.w600))),
            SizedBox(width: 120, child: Text('${money(item.lineCost)} ကျပ်', textAlign: TextAlign.right)),
            SizedBox(
              width: 88,
              child: item.pending
                  ? Text('မပို့ရသေး', textAlign: TextAlign.right, style: TextStyle(color: KasaColors.brown, fontSize: 12, fontWeight: FontWeight.w600))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
