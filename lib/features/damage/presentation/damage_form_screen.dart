import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../products/domain/entities/product_list_item.dart';
import '../../session/session_controller.dart';
import '../data/damage_local_data_source.dart';

const damageReasons = ['ပျက်စီး', 'သက်တမ်းကုန်', 'ပျောက်ဆုံး'];

class DamageFormScreen extends ConsumerStatefulWidget {
  const DamageFormScreen({super.key});

  @override
  ConsumerState<DamageFormScreen> createState() => _DamageFormScreenState();
}

class _DamageFormScreenState extends ConsumerState<DamageFormScreen> {
  final _search = TextEditingController();
  final _qty = TextEditingController(text: '1');
  ProductListItem? _product;
  String _reason = damageReasons.first;
  DateTime _date = DateTime.now();
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _date = DateTime(_date.year, _date.month, _date.day);
  }

  @override
  void dispose() {
    _search.dispose();
    _qty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final query = _search.text.trim();
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('ကုန်ပစ္စည်းဖွင့်မရပါ။')),
        data: (items) {
          final visible = items.where((item) => query.isEmpty || item.nameMm.contains(query)).take(8).toList();
          final qty = MyanmarDigits.parse(_qty.text) ?? 0;
          final cost = _product == null ? 0.0 : qty * _product!.cost;
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            children: [
              Row(
                children: [
                  const Expanded(child: Text('ပျက်စီးအသစ်', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today_outlined, size: 18),
                    label: Text('${_date.day}/${_date.month}/${_date.year}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _search,
                onChanged: (_) => setState(() {}),
                decoration: _input(context,'ကုန်ပစ္စည်းရှာရန်...').copyWith(prefixIcon: const Icon(Icons.search)),
              ),
              const SizedBox(height: 8),
              for (final item in visible)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Material(
                    color: _product?.id == item.id ? const Color(0xFFF3EBE3) : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => _product = item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(child: Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700))),
                            Text('${_plain(item.stock)} ${item.unitMm}', style: const TextStyle(color: KasaColors.muted)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              const Text('အကြောင်းရင်း', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final reason in damageReasons)
                    ChoiceChip(
                      label: Text(reason),
                      selected: _reason == reason,
                      selectedColor: KasaColors.brown,
                      labelStyle: TextStyle(color: _reason == reason ? Colors.white : KasaColors.ink),
                      onSelected: (_) => setState(() => _reason = reason),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('အရေအတွက်', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final next = (MyanmarDigits.parse(_qty.text) ?? 0) - 1;
                      if (next <= 0) return;
                      setState(() => _qty.text = _plain(next));
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  SizedBox(width: 80, child: TextField(controller: _qty, textAlign: TextAlign.center, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))], onChanged: (_) => setState(() {}), decoration: _input(context,_product?.unitMm ?? ''))),
                  IconButton(
                    onPressed: () {
                      final next = (MyanmarDigits.parse(_qty.text) ?? 0) + 1;
                      setState(() => _qty.text = _plain(next));
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                  const Spacer(),
                  Text('${money(cost)} ကျပ်', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: KasaColors.danger)),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Text(_saving ? 'သိမ်းနေသည်' : 'သိမ်းမည်'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(today.year - 2),
      lastDate: DateTime(today.year, today.month, today.day),
    );
    if (picked == null) return;
    setState(() => _date = DateTime(picked.year, picked.month, picked.day));
  }

  Future<void> _save() async {
    final staff = ref.read(sessionProvider);
    final product = _product;
    final qty = MyanmarDigits.parse(_qty.text);
    if (staff == null || product == null) {
      setState(() => _error = 'ကုန်ပစ္စည်းရွေးပါ။');
      return;
    }
    if (qty == null || qty <= 0) {
      setState(() => _error = 'အရေအတွက်ဖြည့်ပါ။');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final result = await DamageLocalDataSource(ref.read(databaseProvider)).save(
      staffId: staff.id,
      damagedAt: _date,
      productId: product.id,
      qty: qty,
      reason: _reason,
    );
    if (!mounted) return;
    if (result.error != null) {
      setState(() {
        _saving = false;
        _error = result.error;
      });
      return;
    }
    ref.invalidate(damageListProvider);
    ref.invalidate(productListProvider);
    ref.invalidate(profitReportProvider);
    ref.invalidate(pendingCountProvider);
    Navigator.pop(context);
  }
}

InputDecoration _input(BuildContext context, String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Theme.of(context).cardColor,
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
  );
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();
