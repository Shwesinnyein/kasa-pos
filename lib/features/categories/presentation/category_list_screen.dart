import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../data/category_local_data_source.dart';
import '../domain/entities/category_item.dart';

class CategoryListScreen extends ConsumerStatefulWidget {
  const CategoryListScreen({super.key});

  @override
  ConsumerState<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends ConsumerState<CategoryListScreen> {
  final _name = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: categories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('အမျိုးအစားဖွင့်မရပါ။')),
        data: (items) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 4),
                  child: Text('အမျိုးအစား', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Text('ကုန်ပစ္စည်းအုပ်စုများ။', style: TextStyle(color: KasaColors.muted)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _name,
                          onSubmitted: (_) => _add(),
                          decoration: InputDecoration(
                            hintText: 'အမျိုးအစားအသစ်...',
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        onPressed: _saving ? null : _add,
                        style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
                        icon: const Icon(Icons.add),
                        label: const Text('ထည့်မည်'),
                      ),
                    ],
                  ),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                    child: Text(_error!, style: const TextStyle(color: KasaColors.danger)),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text('အမျိုးအစားမရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          itemCount: items.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) => _CategoryRow(
                            item: items[index],
                            onRename: () => _rename(items[index]),
                            onHide: () => _hide(items[index]),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _add() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    final message = await CategoryLocalDataSource(ref.read(databaseProvider)).add(_name.text);
    if (!mounted) return;
    if (message != null) {
      setState(() {
        _saving = false;
        _error = message;
      });
      return;
    }
    _name.clear();
    setState(() => _saving = false);
    _refresh();
  }

  Future<void> _rename(CategoryItem item) async {
    final controller = TextEditingController(text: item.nameMm);
    final next = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('အမည်ပြင်မည်'),
        content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(hintText: 'မြန်မာအမည်')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ပယ်ဖျက်မည်')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('သိမ်းမည်'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (next == null || !mounted) return;
    final message = await CategoryLocalDataSource(ref.read(databaseProvider)).rename(item.id, next);
    if (!mounted) return;
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() => _error = null);
    _refresh();
  }

  Future<void> _hide(CategoryItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.nameMm),
        content: const Text('ဤအမျိုးအစားကို ပိတ်မည်။ ကုန်ပစ္စည်းဟောင်းများတွင် ကျန်ရှိမည်။'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ပယ်ဖျက်မည်')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('ပိတ်မည်'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await CategoryLocalDataSource(ref.read(databaseProvider)).hide(item.id);
    if (!mounted) return;
    _refresh();
  }

  void _refresh() {
    ref.invalidate(categoryListProvider);
    ref.invalidate(productListProvider);
    ref.invalidate(pendingCountProvider);
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.item, required this.onRename, required this.onHide});

  final CategoryItem item;
  final VoidCallback onRename;
  final VoidCallback onHide;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(child: Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
            TextButton(onPressed: onRename, child: const Text('ပြင်မည်')),
            TextButton(onPressed: onHide, style: TextButton.styleFrom(foregroundColor: KasaColors.danger), child: const Text('ပိတ်မည်')),
          ],
        ),
      ),
    );
  }
}
