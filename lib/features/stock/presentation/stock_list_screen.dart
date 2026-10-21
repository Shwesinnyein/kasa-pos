import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../products/domain/entities/product_list_item.dart';
import '../../purchases/data/repurchase_local_data_source.dart';
import '../../purchases/presentation/repurchase_detail_screen.dart';

class StockListScreen extends ConsumerStatefulWidget {
  const StockListScreen({super.key});

  @override
  ConsumerState<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends ConsumerState<StockListScreen> {
  String? _categoryId;
  String _query = '';

  Future<void> _repurchase(String productId) async {
    final source = RepurchaseLocalDataSource(ref.read(databaseProvider));
    final id = await source.ensureOpen();
    await source.add(repurchaseId: id, productId: productId);
    await _openRepurchase(id);
  }

  Future<void> _openListed() async {
    final id = await RepurchaseLocalDataSource(ref.read(databaseProvider)).ensureOpen();
    await _openRepurchase(id);
  }

  Future<void> _openRepurchase(String id) async {
    ref.invalidate(repurchaseListProvider);
    ref.invalidate(repurchaseSheetProvider(id));
    if (!mounted) return;
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => RepurchaseDetailScreen(repurchaseId: id)));
    ref.invalidate(repurchaseListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final listed = ref.watch(repurchaseListProvider).maybeWhen(
          data: (docs) => docs.where((doc) => !doc.completed).expand((doc) => doc.productIds).toSet(),
          orElse: () => const <String>{},
        );
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('လက်ကျန်ဖွင့်မရပါ။')),
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
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text('လက်ကျန်', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text('အဝယ်မှ ရောင်းချမှုနှင့် ပျက်စီးကို နုတ်ထားသော လက်ကျန်။', style: TextStyle(color: KasaColors.muted)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
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
                    for (final entry in categories.entries) _Chip(label: entry.value, selected: _categoryId == entry.key, onTap: () => setState(() => _categoryId = entry.key)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (visible.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 8),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text('ကုန်ပစ္စည်း', style: _header)),
                      Expanded(flex: 2, child: Text('အမျိုးအစား', style: _header)),
                      Expanded(flex: 2, child: Text('လက်ကျန်', style: _header)),
                      Expanded(flex: 2, child: Text('ရောင်းပြီး', style: _header)),
                      SizedBox(width: 100, child: Text('အခြေအနေ', textAlign: TextAlign.right, style: _header)),
                      SizedBox(width: _repurchaseWidth, child: Text('ပြန်ဝယ်', textAlign: TextAlign.right, style: _header)),
                    ],
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
                          final already = listed.contains(item.id);
                          return _StockRow(
                            item: item,
                            listed: already,
                            onRepurchase: already ? _openListed : () => _repurchase(item.id),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StockRow extends StatelessWidget {
  const _StockRow({required this.item, required this.listed, required this.onRepurchase});

  final ProductListItem item;
  final bool listed;
  final VoidCallback onRepurchase;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700)),
                  if (listed) Text('စာရင်းတွင်', style: TextStyle(color: KasaColors.brown, fontSize: 12)),
                ],
              ),
            ),
            Expanded(flex: 2, child: Text(item.categoryName, style: const TextStyle(color: KasaColors.muted))),
            Expanded(flex: 2, child: Text('${_plain(item.stock)} ${item.unitMm}', style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text('${_plain(item.soldQty)} ${item.unitMm}', style: const TextStyle(fontWeight: FontWeight.w600))),
            SizedBox(
              width: 100,
              child: item.isLowStock
                  ? const Text('လက်ကျန်နည်း', textAlign: TextAlign.right, style: TextStyle(color: KasaColors.danger, fontSize: 12, fontWeight: FontWeight.w600))
                  : const SizedBox.shrink(),
            ),
            SizedBox(
              width: _repurchaseWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: listed
                    ? TextButton(
                        onPressed: onRepurchase,
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          minimumSize: const Size(0, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text('ထည့်ပြီး'),
                      )
                    : FilledButton(
                        onPressed: onRepurchase,
                        style: FilledButton.styleFrom(
                          backgroundColor: KasaColors.brown,
                          visualDensity: VisualDensity.compact,
                          minimumSize: const Size(0, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Text('ပြန်ဝယ်'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
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

const _repurchaseWidth = 96.0;
const _header = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();
