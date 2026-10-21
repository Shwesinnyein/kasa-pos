import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../data/product_local_data_source.dart';
import '../domain/entities/product_form_data.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  final String? productId;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  late final Future<ProductFormData> _future;

  @override
  void initState() {
    super.initState();
    _future = ProductLocalDataSource(ref.read(databaseProvider)).loadForm(widget.productId);
  }

  final _name = TextEditingController();
  final _unit = TextEditingController();
  final _barcode = TextEditingController();
  final _reorder = TextEditingController();

  ProductFormData? _data;
  String? _categoryId;
  String? _unitId;
  String? _error;
  bool _saving = false;
  bool _addingUnit = false;
  bool _applied = false;

  @override
  void dispose() {
    _name.dispose();
    _unit.dispose();
    _barcode.dispose();
    _reorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: FutureBuilder<ProductFormData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('ကုန်ပစ္စည်းဖွင့်မရပါ။'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          _apply(snapshot.data!);
          final data = _data!;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                children: [
                  Text(data.isNew ? 'ကုန်ပစ္စည်းအသစ်' : 'ကုန်ပစ္စည်းပြင်မည်', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 20),
                  const _Label('အမျိုးအစား'),
                  _FieldBox(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _categoryId,
                        isExpanded: true,
                        hint: const Text('ရွေးပါ'),
                        items: [
                          for (final category in data.categories)
                            DropdownMenuItem(value: category.id, child: Text(category.name)),
                        ],
                        onChanged: (value) => setState(() => _categoryId = value),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _Label('အမည်'),
                  TextField(
                    controller: _name,
                    decoration: _input(context, hint: 'မြန်မာအမည်'),
                  ),
                  const SizedBox(height: 16),
                  const _Label('ထုပ်ပိုးပုံ'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final unit in data.units)
                        ChoiceChip(
                          label: Text(unit.name),
                          selected: _unit.text.isEmpty && _unitId == unit.id,
                          selectedColor: KasaColors.brown,
                          labelStyle: TextStyle(color: _unit.text.isEmpty && _unitId == unit.id ? Colors.white : KasaColors.ink),
                          onSelected: (_) => setState(() {
                            _unit.clear();
                            _unitId = unit.id;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _unit,
                          onSubmitted: (_) => _addUnit(),
                          decoration: _input(context, hint: 'စကားလုံးအသစ်၊ ဥပမာ ဘူး'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: _addingUnit ? null : _addUnit,
                        style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
                        child: const Text('ထည့်မည်'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _Label('ဘားကုဒ်'),
                  TextField(
                    controller: _barcode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉]'))],
                    decoration: _input(context, hint: 'မထည့်လည်းရသည်'),
                  ),
                  const SizedBox(height: 16),
                  const _Label('ပြန်မှာရန်'),
                  TextField(
                    controller: _reorder,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                    decoration: _input(context, hint: 'မထည့်လည်းရသည်'),
                  ),
                  const SizedBox(height: 12),
                  const Text('ရောင်းဈေးကို ရောင်းဈေးစာမျက်နှာတွင် သတ်မှတ်ပါ။ အရင်းဈေးကို အဝယ်မှ သတ်မှတ်သည်။', style: TextStyle(color: KasaColors.muted)),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: const TextStyle(color: KasaColors.danger)),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _saving ? null : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: KasaColors.ink,
                            side: const BorderSide(color: KasaColors.line),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('ပယ်ဖျက်မည်'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _saving ? null : _save,
                          style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
                          child: Text(_saving ? 'သိမ်းနေသည်' : 'သိမ်းမည်'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _apply(ProductFormData data) {
    if (_applied) return;
    _applied = true;
    _data = data;
    _categoryId = data.categoryId;
    _unitId = data.unitId;
    _name.text = data.nameMm;
    _barcode.text = data.barcode;
    _reorder.text = _plain(data.reorderLevel);
  }

  Future<void> _addUnit() async {
    final data = _data;
    if (data == null || _addingUnit) return;
    setState(() {
      _addingUnit = true;
      _error = null;
    });
    final result = await ProductLocalDataSource(ref.read(databaseProvider)).addUnit(_unit.text);
    if (!mounted) return;
    if (result.id == null) {
      setState(() {
        _addingUnit = false;
        _error = result.error;
      });
      return;
    }
    final units = [
      for (final unit in data.units)
        if (unit.id != result.id) unit,
      NamedOption(result.id!, _unit.text.trim()),
    ]..sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _addingUnit = false;
      _unitId = result.id;
      _unit.clear();
      _data = ProductFormData(
        categories: data.categories,
        units: units,
        id: data.id,
        nameMm: data.nameMm,
        categoryId: data.categoryId,
        unitId: result.id,
        barcode: data.barcode,
        price: data.price,
        reorderLevel: data.reorderLevel,
        cost: data.cost,
      );
    });
  }

  Future<void> _save() async {
    final data = _data;
    if (data == null) return;
    final reorderText = _reorder.text.trim();
    final reorder = reorderText.isEmpty ? null : MyanmarDigits.parse(reorderText);
    if (reorderText.isNotEmpty && reorder == null) {
      setState(() => _error = 'ပြန်မှာရန် ဂဏန်းဖြစ်ရမည်။');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final message = await ProductLocalDataSource(ref.read(databaseProvider)).save(
      ProductDraft(
        id: data.id,
        nameMm: _name.text,
        categoryId: _categoryId,
        unitId: _unit.text.trim().isEmpty ? _unitId : null,
        unitName: _unit.text,
        barcode: _barcode.text,
        reorderLevel: reorder,
      ),
    );
    if (!mounted) return;
    if (message != null) {
      setState(() {
        _saving = false;
        _error = message;
      });
      return;
    }
    ref.invalidate(productListProvider);
    ref.invalidate(saleCatalogProvider);
    ref.invalidate(pendingCountProvider);
    Navigator.pop(context);
  }
}

String _plain(double? value) {
  if (value == null) return '';
  if (value == value.roundToDouble()) return value.round().toString();
  return value.toString();
}

InputDecoration _input(BuildContext context, {required String hint}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Theme.of(context).cardColor,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
  );
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
    );
  }
}

class _FieldBox extends StatelessWidget {
  const _FieldBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KasaColors.line),
      ),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: child),
    );
  }
}
