import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../domain/entities/sale_record.dart';
import '../domain/sale_math.dart';

class SaleDetailScreen extends ConsumerWidget {
  const SaleDetailScreen({super.key, required this.saleId});

  final String saleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sale = ref.watch(saleDetailProvider(saleId));
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: sale.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အရောင်းဖွင့်မရပါ။')),
        data: (item) => item == null ? const Center(child: Text('အရောင်းမရှိပါ။')) : _SaleDetail(sale: item),
      ),
    );
  }
}

class _SaleDetail extends StatelessWidget {
  const _SaleDetail({required this.sale});

  final SaleRecord sale;

  @override
  Widget build(BuildContext context) {
    final change = SaleMath.change(total: sale.total, paid: sale.paidAmount, payment: sale.payment);
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      children: [
        Text(saleListLabel(sale.saleNo), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(_day(sale.soldAt), style: const TextStyle(color: KasaColors.muted)),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(flex: 3, child: Text('ကုန်ပစ္စည်း', style: _header)),
            Expanded(flex: 2, child: Text('ရောင်းပုံ', style: _header)),
            Expanded(flex: 3, child: Text('အရေအတွက်', style: _header)),
            Expanded(flex: 2, child: Text('ဈေး', style: _header)),
            Expanded(flex: 2, child: Text('ငွေပမာဏ', textAlign: TextAlign.right, style: _header)),
          ],
        ),
        const SizedBox(height: 8),
        if (sale.lines.isEmpty) const Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)),
        for (final line in sale.lines)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(line.nameMm.isEmpty ? '—' : line.nameMm, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                Expanded(flex: 2, child: Text(line.asPack ? 'ဖာ' : '${line.unitMm}ချင်း')),
                Expanded(flex: 3, child: Text(_qty(line), style: const TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('${money(line.unitPrice)} ကျပ်')),
                Expanded(flex: 2, child: Text('${money(line.lineTotal)} ကျပ်', textAlign: TextAlign.right)),
              ],
            ),
          ),
        const SizedBox(height: 8),
        _amount('လျှော့ဈေး', sale.discount),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              const Text('ငွေပေးချေမှု', style: TextStyle(color: KasaColors.muted)),
              const Spacer(),
              Text(_paymentLabel(sale.payment)),
            ],
          ),
        ),
        if (sale.payment == PaymentMethod.cash) ...[
          _amount('ရငွေ', sale.paidAmount),
          _amount('ပြန်အမ်း', change),
        ],
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text('${money(sale.total)} ကျပ်', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

Widget _amount(String label, double value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(label, style: const TextStyle(color: KasaColors.muted)),
        const Spacer(),
        Text('${money(value)} ကျပ်'),
      ],
    ),
  );
}

String _paymentLabel(PaymentMethod payment) {
  return switch (payment) {
    PaymentMethod.cash => 'ငွေသား',
    PaymentMethod.card => 'ကတ်',
    PaymentMethod.transfer => 'ဘဏ်လွှဲ',
  };
}

String _qty(SaleLineRecord line) {
  final amount = _plain(line.qty);
  if (line.asPack) return '$amount ဖာ · ၁ ဖာ = ${_plain(line.packSize)} ${line.unitMm}';
  return '$amount ${line.unitMm}';
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
