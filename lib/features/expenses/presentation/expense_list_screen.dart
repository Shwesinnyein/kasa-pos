import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../session/session_controller.dart';
import '../data/expense_local_data_source.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: expenses.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အသုံးစရိတ်ဖွင့်မရပါ။')),
        data: (items) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  const Expanded(child: Text('အသုံးစရိတ်', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ExpenseFormScreen())),
                    style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                    icon: const Icon(Icons.add),
                    label: const Text('အသုံးစရိတ်အသစ်'),
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
                    Expanded(child: Text('အမျိုးအစား', style: _header)),
                    Expanded(flex: 2, child: Text('အမည်', style: _header)),
                    SizedBox(width: 140, child: Text('ငွေပမာဏ', textAlign: TextAlign.right, style: _header)),
                    SizedBox(width: 88, child: Text('အခြေအနေ', textAlign: TextAlign.right, style: _header)),
                  ],
                ),
              ),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('အသုံးစရိတ်မရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Material(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                SizedBox(width: 94, child: Text(_day(item.spentAt))),
                                Expanded(child: Text(item.categoryName, style: const TextStyle(color: KasaColors.muted))),
                                Expanded(flex: 2, child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700))),
                                SizedBox(width: 140, child: Text('${money(item.amount)} ကျပ်', textAlign: TextAlign.right)),
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseFormScreen extends ConsumerStatefulWidget {
  const ExpenseFormScreen({super.key});

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  final _type = TextEditingController();
  String? _categoryId;
  DateTime _date = DateTime.now();
  String? _error;
  bool _saving = false;
  bool _addingType = false;

  @override
  void initState() {
    super.initState();
    _date = DateTime(_date.year, _date.month, _date.day);
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _note.dispose();
    _type.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(expenseCategoryProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: categories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အမျိုးအစားဖွင့်မရပါ။')),
        data: (items) {
          _categoryId ??= items.isEmpty ? null : items.first.id;
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            children: [
              const Text('အသုံးစရိတ်အသစ်', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              const Text('ရက်စွဲ', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _pickDate,
                style: OutlinedButton.styleFrom(
                  foregroundColor: KasaColors.ink,
                  backgroundColor: Theme.of(context).cardColor,
                  side: const BorderSide(color: KasaColors.line),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  alignment: Alignment.centerLeft,
                ),
                icon: const Icon(Icons.calendar_today_outlined, size: 18),
                label: Text('${_date.day}/${_date.month}/${_date.year}'),
              ),
              const SizedBox(height: 16),
              const Text('အမျိုးအစား', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final category in items)
                    ChoiceChip(
                      label: Text(category.name),
                      selected: _categoryId == category.id,
                      selectedColor: KasaColors.brown,
                      labelStyle: TextStyle(color: _categoryId == category.id ? Colors.white : KasaColors.ink),
                      onSelected: (_) => setState(() => _categoryId = category.id),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: TextField(controller: _type, onSubmitted: (_) => _addType(), decoration: _input(context,'အမျိုးအစားအသစ်'))),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _addingType ? null : _addType,
                    style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
                    child: const Text('ထည့်မည်'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('အမည်', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(controller: _title, decoration: _input(context,'ဥပမာ မီးဖိုး')),
              const SizedBox(height: 16),
              const Text('ငွေပမာဏ', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(
                controller: _amount,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: KasaColors.brown),
                decoration: _input(context,'0').copyWith(suffixText: 'ကျပ်'),
              ),
              const SizedBox(height: 16),
              const Text('မှတ်ချက်', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextField(controller: _note, decoration: _input(context,'မထည့်လည်းရသည်')),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: KasaColors.danger)),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _saving ? null : () => _save(items),
                style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Text(_saving ? 'သိမ်းနေသည်' : 'သိမ်းမည်'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addType() async {
    if (_addingType) return;
    setState(() {
      _addingType = true;
      _error = null;
    });
    final result = await ExpenseLocalDataSource(ref.read(databaseProvider)).addCategory(_type.text);
    if (!mounted) return;
    if (result.id == null) {
      setState(() {
        _addingType = false;
        _error = result.error;
      });
      return;
    }
    _type.clear();
    setState(() {
      _addingType = false;
      _categoryId = result.id;
    });
    ref.invalidate(expenseCategoryProvider);
    ref.invalidate(pendingCountProvider);
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

  Future<void> _save(List<ExpenseCategoryOption> categories) async {
    final staff = ref.read(sessionProvider);
    final amount = MyanmarDigits.parse(_amount.text);
    if (staff == null) return;
    if (_categoryId == null || categories.isEmpty) {
      setState(() => _error = 'အမျိုးအစားရွေးပါ။');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final message = await ExpenseLocalDataSource(ref.read(databaseProvider)).save(
      staffId: staff.id,
      categoryId: _categoryId!,
      title: _title.text,
      amount: amount ?? 0,
      spentAt: _date,
      note: _note.text,
    );
    if (!mounted) return;
    if (message != null) {
      setState(() {
        _saving = false;
        _error = message;
      });
      return;
    }
    ref.invalidate(expenseListProvider);
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
  );
}

const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';
