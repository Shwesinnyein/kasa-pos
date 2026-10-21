import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../app/theme.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../products/domain/entities/product_list_item.dart';
import '../data/repurchase_local_data_source.dart';
import '../domain/entities/purchase_models.dart';
import 'purchase_form_screen.dart';
import 'repurchase_pdf.dart';

class RepurchaseDetailScreen extends ConsumerStatefulWidget {
  const RepurchaseDetailScreen({super.key, required this.repurchaseId});

  final String repurchaseId;

  @override
  ConsumerState<RepurchaseDetailScreen> createState() => _RepurchaseDetailScreenState();
}

class _RepurchaseDetailScreenState extends ConsumerState<RepurchaseDetailScreen> {
  final _search = TextEditingController();
  final _single = <String, double>{};
  final _pack = <String, double>{};
  String _query = '';
  String? _error;
  bool _exporting = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final sheet = ref.watch(repurchaseSheetProvider(widget.repurchaseId));
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('ပြန်ဝယ်ဖွင့်မရပါ။')),
        data: (items) => sheet.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Center(child: Text('ပြန်ဝယ်ဖွင့်မရပါ။')),
          data: (loaded) => loaded == null ? const Center(child: Text('ပြန်ဝယ်ဖွင့်မရပါ။')) : _body(items, loaded),
        ),
      ),
    );
  }

  Widget _body(List<ProductListItem> items, RepurchaseSheet sheet) {
    final completed = sheet.document.completed;
    final byId = {for (final item in items) item.id: item};
    final rows = [for (final entry in sheet.items) if (byId[entry.productId] != null) (entry: entry, product: byId[entry.productId]!)];
    final query = _query.trim();
    final nameMatches = query.isEmpty ? const <ProductListItem>[] : items.where((item) => item.nameMm.contains(query)).take(8).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(repurchaseListLabel(sheet.document.repurchaseNo), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
              OutlinedButton.icon(
                onPressed: rows.isEmpty || _exporting ? null : () => _download(rows),
                icon: const Icon(Icons.download_outlined, size: 18),
                label: const Text('ဒေါင်းလုဒ်'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: rows.isEmpty || _exporting ? null : () => _print(rows),
                icon: const Icon(Icons.print_outlined, size: 18),
                label: const Text('ပုံနှိပ်မည်'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            completed ? 'ဒီပြန်ဝယ် ပြီးပါပြီ။' : 'အရေအတွက်ဖြည့်ပါ။ အဝယ်လုပ်မည်ကို နှိပ်ရင် အဝယ်ဈေးနှင့် ဖာ၊ ချင်း ပြင်နိုင်သည်။',
            style: const TextStyle(color: KasaColors.muted),
          ),
          if (!completed) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _search,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'ကုန်ပစ္စည်းရှာပြီး ထည့်မည်',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
            ),
          ),
          if (nameMatches.isNotEmpty) ...[
            const SizedBox(height: 8),
            for (final item in nameMatches)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Material(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.nameMm, style: const TextStyle(fontWeight: FontWeight.w700))),
                        Text('${_plain(item.stock)} ${item.unitMm}', style: const TextStyle(color: KasaColors.muted)),
                        const SizedBox(width: 12),
                        FilledButton(
                          onPressed: () => _add(item.id),
                          style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, visualDensity: VisualDensity.compact),
                          child: const Text('ထည့်မည်'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
          ],
          const SizedBox(height: 12),
          Expanded(
            child: rows.isEmpty
                ? const Center(child: Text('ပြန်ဝယ်စာရင်းမရှိသေးပါ။', style: TextStyle(color: KasaColors.muted)))
                : ListView.separated(
                    itemCount: rows.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final row = rows[index];
                      return _RepurchaseRow(
                        key: ValueKey(row.entry.id),
                        entry: row.entry,
                        product: row.product,
                        enabled: !completed,
                        onSingle: (qty) {
                          _single[row.entry.id] = qty;
                          RepurchaseLocalDataSource(ref.read(databaseProvider)).setSingle(row.entry.id, qty);
                        },
                        onPack: (qty) {
                          _pack[row.entry.id] = qty;
                          RepurchaseLocalDataSource(ref.read(databaseProvider)).setPackQty(row.entry.id, qty);
                        },
                        onRemove: () => _remove(row.entry.id),
                      );
                    },
                  ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(color: KasaColors.danger)),
          ],
          if (!completed) ...[
          const SizedBox(height: 8),
          FilledButton(
            onPressed: rows.isEmpty ? null : () => _buy(rows),
            style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text('အဝယ်လုပ်မည်'),
          ),
          ],
        ],
      ),
    );
  }

  void _refresh() {
    ref.invalidate(repurchaseListProvider);
    ref.invalidate(repurchaseSheetProvider(widget.repurchaseId));
  }

  Future<void> _add(String productId) async {
    await RepurchaseLocalDataSource(ref.read(databaseProvider)).add(repurchaseId: widget.repurchaseId, productId: productId);
    _refresh();
    _search.clear();
    setState(() {
      _query = '';
      _error = null;
    });
  }

  Future<void> _remove(String id) async {
    _single.remove(id);
    _pack.remove(id);
    await RepurchaseLocalDataSource(ref.read(databaseProvider)).remove(id);
    _refresh();
  }

  Future<void> _buy(List<({RepurchaseEntry entry, ProductListItem product})> rows) async {
    final seeds = <PurchaseSeed>[];
    for (final row in rows) {
      final single = _single[row.entry.id] ?? row.entry.qty;
      final pack = _pack[row.entry.id] ?? row.entry.packQty;
      final size = row.entry.packSize > 1 ? row.entry.packSize : (row.product.packSize ?? 1);
      if (single <= 0 && pack <= 0) {
        setState(() => _error = 'အရေအတွက်ဖြည့်ပါ။');
        return;
      }
      if (pack > 0) seeds.add(PurchaseSeed(productId: row.entry.productId, qty: pack, packSize: size, asPack: true));
      if (single > 0) seeds.add(PurchaseSeed(productId: row.entry.productId, qty: single));
    }
    setState(() => _error = null);
    final finished = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => PurchaseFormScreen(seeds: seeds, repurchaseId: widget.repurchaseId)),
    );
    if (!mounted) return;
    if (finished == true) {
      Navigator.of(context).pop();
      return;
    }
    _single.clear();
    _pack.clear();
    _refresh();
  }

  List<RepurchasePdfLine> _pdfLines(List<({RepurchaseEntry entry, ProductListItem product})> rows) {
    return [
      for (final row in rows)
        if ((_pack[row.entry.id] ?? row.entry.packQty) > 0 || (_single[row.entry.id] ?? row.entry.qty) > 0)
          RepurchasePdfLine(
            name: row.product.nameMm,
            unit: row.product.unitMm,
            pack: _pack[row.entry.id] ?? row.entry.packQty,
            single: _single[row.entry.id] ?? row.entry.qty,
          ),
    ];
  }

  Future<Uint8List?> _pdf(List<({RepurchaseEntry entry, ProductListItem product})> rows) async {
    final lines = _pdfLines(rows);
    if (lines.isEmpty) {
      setState(() => _error = 'အရေအတွက်ဖြည့်ပါ။');
      return null;
    }
    setState(() {
      _exporting = true;
      _error = null;
    });
    final shop = ref.read(shopProfileProvider).value?.displayName ?? '';
    final bytes = await buildRepurchasePdf(shopName: shop.isEmpty ? 'ဆိုင်' : shop, date: DateTime.now(), lines: lines);
    if (mounted) setState(() => _exporting = false);
    return bytes;
  }

  Future<void> _download(List<({RepurchaseEntry entry, ProductListItem product})> rows) async {
    final bytes = await _pdf(rows);
    if (bytes == null || !mounted) return;
    final today = DateTime.now();
    final name = 'ပြန်ဝယ်စာရင်း-${today.year}-${today.month}-${today.day}.pdf';
    final location = await getSaveLocation(
      suggestedName: name,
      acceptedTypeGroups: const [XTypeGroup(label: 'PDF', extensions: ['pdf'], uniformTypeIdentifiers: ['com.adobe.pdf'])],
    );
    if (location == null) return;
    try {
      await XFile.fromData(bytes, mimeType: 'application/pdf', name: name).saveTo(location.path);
    } catch (_) {
      if (mounted) setState(() => _error = 'ဒေါင်းလုဒ်မရပါ။');
    }
  }

  Future<void> _print(List<({RepurchaseEntry entry, ProductListItem product})> rows) async {
    final bytes = await _pdf(rows);
    if (bytes == null || !mounted) return;
    try {
      await Printing.layoutPdf(name: 'ပြန်ဝယ်စာရင်း', onLayout: (_) async => bytes);
    } catch (_) {
      if (mounted) setState(() => _error = 'ပုံနှိပ်မရပါ။');
    }
  }
}

class _RepurchaseRow extends StatefulWidget {
  const _RepurchaseRow({
    super.key,
    required this.entry,
    required this.product,
    required this.enabled,
    required this.onSingle,
    required this.onPack,
    required this.onRemove,
  });

  final RepurchaseEntry entry;
  final ProductListItem product;
  final bool enabled;
  final ValueChanged<double> onSingle;
  final ValueChanged<double> onPack;
  final VoidCallback onRemove;

  @override
  State<_RepurchaseRow> createState() => _RepurchaseRowState();
}

class _RepurchaseRowState extends State<_RepurchaseRow> {
  late final TextEditingController _single;
  late final TextEditingController _pack;

  @override
  void initState() {
    super.initState();
    _single = TextEditingController(text: widget.entry.qty > 0 ? _plain(widget.entry.qty) : '');
    _pack = TextEditingController(text: widget.entry.packQty > 0 ? _plain(widget.entry.packQty) : '');
  }

  @override
  void dispose() {
    _single.dispose();
    _pack.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(child: Text(product.nameMm, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
            _Amount(controller: _pack, enabled: widget.enabled, onChanged: widget.onPack),
            const SizedBox(width: 8),
            const Text('ဖာ'),
            const SizedBox(width: 20),
            _Amount(controller: _single, enabled: widget.enabled, onChanged: widget.onSingle),
            const SizedBox(width: 8),
            Text(product.unitMm),
            if (widget.enabled) ...[
              const SizedBox(width: 8),
              TextButton(onPressed: widget.onRemove, child: const Text('ဖယ်မည်')),
            ],
          ],
        ),
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({required this.controller, required this.enabled, required this.onChanged});

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: TextField(
        controller: controller,
        readOnly: !enabled,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
        onChanged: (value) {
          final qty = MyanmarDigits.parse(value);
          onChanged(qty == null || qty < 0 ? 0 : qty);
        },
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: KasaColors.background,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: KasaColors.line)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: KasaColors.line)),
        ),
      ),
    );
  }
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();
