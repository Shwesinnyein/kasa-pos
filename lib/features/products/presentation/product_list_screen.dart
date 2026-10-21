import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../domain/entities/product_list_item.dart';
import 'product_form_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  String? _categoryId;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('ကုန်ပစ္စည်းဖွင့်မရပါ။ $error')),
        data: (items) {
          final categories = <String, String>{for (final item in items) item.categoryId: item.categoryName};
          final visible = items.where((item) {
            final categoryOk = _categoryId == null || item.categoryId == _categoryId;
            final queryOk = _query.trim().isEmpty || item.nameMm.contains(_query.trim());
            return categoryOk && queryOk;
          }).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Row(
                  children: [
                    const Expanded(child: Text('ကုန်ပစ္စည်း', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
                    FilledButton.icon(
                      onPressed: () => _openForm(context, null),
                      style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
                      icon: const Icon(Icons.add),
                      label: const Text('ထည့်မည်'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'ကုန်ပစ္စည်းရှာရန်...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _Chip(label: 'အားလုံး', selected: _categoryId == null, onTap: () => setState(() => _categoryId = null)),
                    for (final entry in categories.entries)
                      _Chip(label: entry.value, selected: _categoryId == entry.key, onTap: () => setState(() => _categoryId = entry.key)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 8),
                child: _ProductColumns(
                  name: Text('ကုန်ပစ္စည်း', style: _headerStyle),
                  category: Text('အမျိုးအစား', style: _headerStyle),
                  unit: Text('ယူနစ်', style: _headerStyle),
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? const Center(child: Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        itemCount: visible.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = visible[index];
                          return _ProductRow(item: item, onTap: () => _openForm(context, item));
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openForm(BuildContext context, ProductListItem? item) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ProductFormScreen(productId: item?.id)));
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: KasaColors.brown,
        labelStyle: TextStyle(color: selected ? Colors.white : KasaColors.ink),
      ),
    );
  }
}

const _headerStyle = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

class _ProductColumns extends StatelessWidget {
  const _ProductColumns({required this.name, required this.category, required this.unit});

  final Widget name;
  final Widget category;
  final Widget unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: name),
        Expanded(flex: 2, child: category),
        Expanded(flex: 2, child: unit),
      ],
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.item, required this.onTap});

  final ProductListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: _ProductColumns(
            name: Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            category: Text(item.categoryName),
            unit: Text(item.unitMm, style: const TextStyle(color: KasaColors.muted)),
          ),
        ),
      ),
    );
  }
}
