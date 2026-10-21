import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../products/data/product_local_data_source.dart';
import '../../products/domain/entities/product_list_item.dart';
import 'purchase_price_history_screen.dart';

class SellingPriceScreen extends ConsumerStatefulWidget {
  const SellingPriceScreen({super.key});

  @override
  ConsumerState<SellingPriceScreen> createState() => _SellingPriceScreenState();
}

class _PriceDraft {
  _PriceDraft({
    required String single,
    required String pack,
    required String pieces,
    required this.packFollows,
  })  : single = TextEditingController(text: single),
        pack = TextEditingController(text: pack),
        pieces = TextEditingController(text: pieces);

  final TextEditingController single;
  final TextEditingController pack;
  final TextEditingController pieces;
  bool packFollows;

  void dispose() {
    single.dispose();
    pack.dispose();
    pieces.dispose();
  }
}

class _SellingPriceScreenState extends ConsumerState<SellingPriceScreen> {
  final _query = TextEditingController();
  final _drafts = <String, _PriceDraft>{};
  String? _categoryId;
  String? _savingId;
  final _saved = <String>{};
  String? _errorId;
  String? _error;

  @override
  void dispose() {
    _query.dispose();
    for (final draft in _drafts.values) {
      draft.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('ရောင်းဈေးဖွင့်မရပါ။')),
        data: (items) {
          final query = _query.text.trim();
          final categories = <String, String>{for (final item in items) item.categoryId: item.categoryName};
          final visible = items.where((item) {
            final categoryOk = _categoryId == null || item.categoryId == _categoryId;
            final queryOk = query.isEmpty || item.nameMm.contains(query);
            return categoryOk && queryOk;
          }).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 4),
                child: Text('ရောင်းဈေး', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text('အကွက်ထဲက ဈေးက ယခုဈေး။ ဈေးပြောင်းပြီး သိမ်းရင် ယခင်ဈေးကို အောက်မှာ ပြသည်။', style: TextStyle(color: KasaColors.muted)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: TextField(
                  controller: _query,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'ကုန်ပစ္စည်းရှာရန်...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: visible.isEmpty
                      ? const Center(child: Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)))
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: KasaColors.line),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth < 1080 ? 1080.0 : constraints.maxWidth;
                              return Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: width,
                                    child: Column(
                                      children: [
                                        const _TableHead(),
                                        const Divider(height: 1, color: KasaColors.line),
                                        Expanded(
                                          child: ListView.separated(
                                            itemCount: visible.length,
                                            separatorBuilder: (context, index) => const Divider(height: 1, color: KasaColors.line),
                                            itemBuilder: (context, index) => _row(visible[index]),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _row(ProductListItem item) {
    final pieces = item.packSize != null && item.packSize! > 1 ? _plain(item.packSize!) : '';
    final single = item.price > 0 ? _plain(item.price) : '';
    final draft = _drafts.putIfAbsent(
      item.id,
      () => _PriceDraft(
        single: single,
        pack: item.packPrice != null && item.packPrice! > 0 ? _plain(item.packPrice!) : _times(single, pieces),
        pieces: pieces,
        packFollows: item.packPrice == null || item.packPrice! <= 0,
      ),
    );
    final saving = _savingId == item.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _cells(
          name: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => PurchasePriceHistoryScreen(productId: item.id, nameMm: item.nameMm, unitMm: item.unitMm),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700)),
                Text('အဝယ်ဈေး', style: TextStyle(color: KasaColors.brown, fontSize: 12)),
              ],
            ),
          ),
          category: Text(item.categoryName, style: const TextStyle(color: KasaColors.muted)),
          unit: Text(item.unitMm),
          buy: _readOnly(_shown(item.buyPrice, item.cost)),
          packBuy: _readOnly(_packBuy(item)),
          sell: _priced(item, draft.single, item.previousPrice, item.price, onChanged: () => _syncDerived(draft)),
          packSell: _priced(item, draft.pack, item.previousPackPrice, item.packPrice, onChanged: () => draft.packFollows = draft.pack.text.trim().isEmpty),
          pieces: _cell(item, draft.pieces, suffix: item.unitMm, onChanged: () => _syncDerived(draft)),
          action: saving
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : _saved.contains(item.id)
                  ? const Text('ပြီး', style: TextStyle(color: KasaColors.online, fontWeight: FontWeight.w700))
                  : TextButton(onPressed: () => _save(item), child: const Text('သိမ်းမည်')),
        ),
        if (_errorId == item.id && _error != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(_error!, style: const TextStyle(color: KasaColors.danger)),
          ),
      ],
    );
  }

  void _syncDerived(_PriceDraft draft) {
    if (draft.packFollows) draft.pack.text = _times(draft.single.text, draft.pieces.text);
  }

  Widget _readOnly(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(text, textAlign: TextAlign.right, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
    );
  }

  Widget _priced(ProductListItem item, TextEditingController controller, double? previous, double? current, {VoidCallback? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _cell(item, controller, onChanged: onChanged),
        if (previous != null && previous > 0 && previous != current)
          Text(
            'ယခင် ${money(previous)}',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 11, color: KasaColors.muted, decoration: TextDecoration.lineThrough),
          ),
      ],
    );
  }

  Widget _cell(ProductListItem item, TextEditingController controller, {String? suffix, VoidCallback? onChanged}) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: KasaColors.brown),
      onChanged: (_) {
        onChanged?.call();
        _syncDerived(_drafts[item.id]!);
        _clearStatus(item.id);
      },
      decoration: _box().copyWith(
        suffixText: suffix,
        suffixStyle: const TextStyle(fontSize: 12, color: KasaColors.muted, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _clearStatus(String id) {
    if (!_saved.contains(id) && _errorId != id) return;
    setState(() {
      _saved.remove(id);
      if (_errorId == id) {
        _errorId = null;
        _error = null;
      }
    });
  }

  Future<void> _save(ProductListItem item) async {
    final draft = _drafts[item.id];
    if (draft == null) return;
    final single = MyanmarDigits.parse(draft.single.text);
    final packText = draft.pack.text.trim();
    final pack = packText.isEmpty ? null : MyanmarDigits.parse(packText);
    final piecesText = draft.pieces.text.trim();
    final pieces = piecesText.isEmpty ? null : MyanmarDigits.parse(piecesText);
    if (single == null || single <= 0) {
      setState(() {
        _errorId = item.id;
        _error = 'တစ်ခုချင်း ရောင်းဈေးဖြည့်ပါ။';
        _saved.remove(item.id);
      });
      return;
    }
    if (packText.isNotEmpty && (pack == null || pack <= 0)) {
      setState(() {
        _errorId = item.id;
        _error = 'ဖာ ရောင်းဈေးဖြည့်ပါ။';
        _saved.remove(item.id);
      });
      return;
    }
    if ((pack != null || (item.packBuyPrice != null && item.packBuyPrice! > 0)) && (pieces == null || pieces <= 1)) {
      setState(() {
        _errorId = item.id;
        _error = '၁ ဖာတွင် အရေအတွက်ဖြည့်ပါ။';
        _saved.remove(item.id);
      });
      return;
    }
    setState(() => _savingId = item.id);
    final message = await ProductLocalDataSource(ref.read(databaseProvider)).setPrices(
      item.id,
      price: single,
      packPrice: pack,
      packSize: pieces,
      buyPrice: item.buyPrice,
      packBuyPrice: item.packBuyPrice,
    );
    if (!mounted) return;
    setState(() {
      _savingId = null;
      if (message == null) {
        _saved.add(item.id);
        _errorId = null;
        _error = null;
      } else {
        _errorId = item.id;
        _error = message;
      }
    });
    if (message == null) {
      ref.invalidate(productListProvider);
      ref.invalidate(saleCatalogProvider);
      ref.invalidate(pendingCountProvider);
    }
  }
}

String _times(String priceText, String piecesText) {
  final price = MyanmarDigits.parse(priceText);
  final pieces = MyanmarDigits.parse(piecesText);
  if (price == null || price <= 0 || pieces == null || pieces <= 1) return '';
  return _plain(price * pieces);
}

String _packBuy(ProductListItem item) {
  if (item.packBuyPrice != null && item.packBuyPrice! > 0) return _whole(item.packBuyPrice!);
  final each = item.buyPrice != null && item.buyPrice! > 0 ? item.buyPrice! : item.cost;
  final pieces = item.packSize;
  if (each > 0 && pieces != null && pieces > 1) return _whole(each * pieces);
  return '';
}

String _shown(double? listed, double cost) {
  if (listed != null && listed > 0) return _whole(listed);
  if (cost > 0) return _whole(cost);
  return '';
}

String _whole(double value) => value.round().toString();

String _plain(double value) {
  if (value == value.roundToDouble()) return value.round().toString();
  return value.toString();
}

InputDecoration _box() {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: KasaColors.card,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: KasaColors.brown, width: 1.4)),
  );
}

class _TableHead extends StatelessWidget {
  const _TableHead();

  @override
  Widget build(BuildContext context) {
    const group = TextStyle(color: KasaColors.muted, fontSize: 12, fontWeight: FontWeight.w700);
    const label = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w700);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Row(
            children: [
              Expanded(flex: 3, child: SizedBox.shrink()),
              Expanded(flex: 2, child: SizedBox.shrink()),
              SizedBox(width: 64),
              SizedBox(width: _group, child: Text('ဝယ်ဈေး', textAlign: TextAlign.center, style: group)),
              SizedBox(width: 17, child: Center(child: SizedBox(width: 1, height: 18, child: ColoredBox(color: KasaColors.brown)))),
              SizedBox(width: _group, child: Text('ရောင်းဈေး', textAlign: TextAlign.center, style: group)),
              SizedBox(width: 96),
              SizedBox(width: 88),
            ],
          ),
        ),
        _cells(
          name: const Text('ကုန်ပစ္စည်း', style: label),
          category: const Text('အမျိုးအစား', style: label),
          unit: const Text('ယူနစ်', style: label),
          buy: const Text('ချင်း', textAlign: TextAlign.right, style: label),
          packBuy: const Text('ဖာ', textAlign: TextAlign.right, style: label),
          sell: const Text('ချင်း', textAlign: TextAlign.right, style: label),
          packSell: const Text('ဖာ', textAlign: TextAlign.right, style: label),
          pieces: const Text('၁ ဖာ =', textAlign: TextAlign.right, style: label),
          action: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

const _price = 124.0;
const _between = 20.0;
const _group = _price * 2 + _between;

Widget _cells({
  required Widget name,
  required Widget category,
  required Widget unit,
  required Widget buy,
  required Widget packBuy,
  required Widget sell,
  required Widget packSell,
  required Widget pieces,
  required Widget action,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: IntrinsicHeight(
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 3, child: name),
        Expanded(flex: 2, child: category),
        SizedBox(width: 64, child: unit),
        SizedBox(width: _price, child: buy),
        const SizedBox(width: _between),
        SizedBox(width: _price, child: packBuy),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: VerticalDivider(width: 1, thickness: 1, color: KasaColors.brown),
        ),
        SizedBox(width: _price, child: sell),
        const SizedBox(width: _between),
        SizedBox(width: _price, child: packSell),
        SizedBox(width: 96, child: pieces),
        SizedBox(width: 88, child: Align(alignment: Alignment.centerRight, child: action)),
      ],
      ),
    ),
  );
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
