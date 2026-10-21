import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../session/session_controller.dart';
import '../data/purchase_local_data_source.dart';
import '../data/repurchase_local_data_source.dart';
import '../domain/entities/purchase_models.dart';
import 'repurchase_detail_screen.dart';

class PurchaseFormScreen extends ConsumerStatefulWidget {
  const PurchaseFormScreen({super.key, this.purchaseId, this.editing = false, this.seeds = const [], this.repurchaseId});

  final String? purchaseId;
  final bool editing;
  final List<PurchaseSeed> seeds;
  final String? repurchaseId;

  @override
  ConsumerState<PurchaseFormScreen> createState() => _PurchaseFormScreenState();
}

class _DraftLine {
  _DraftLine({required this.product, required this.qty, required this.cost, required this.pieces, this.asPack = false});

  final PurchaseProduct product;
  final TextEditingController qty;
  final TextEditingController cost;
  final TextEditingController pieces;
  bool asPack = false;

  void dispose() {
    qty.dispose();
    cost.dispose();
    pieces.dispose();
  }
}

class _PurchaseFormScreenState extends ConsumerState<PurchaseFormScreen> {
  final _search = TextEditingController();
  final _supplier = TextEditingController();
  final _newName = TextEditingController();
  final _newCost = TextEditingController();
  final _newPieces = TextEditingController();
  final _lines = <_DraftLine>[];

  PurchaseCatalog? _catalog;
  PurchaseDetail? _saved;
  String? _categoryId;
  String? _pickedSupplier;
  DateTime _date = DateTime.now();
  String? _error;
  bool _saving = false;
  bool _loading = true;
  bool _creating = false;
  bool _adding = false;
  bool _newAsPack = false;
  String? _newCategoryId;
  String? _newUnitId;
  String? _loadError;

  bool get _viewing => widget.purchaseId != null && !widget.editing;

  @override
  void initState() {
    super.initState();
    _date = DateTime(_date.year, _date.month, _date.day);
    _load();
  }

  Future<void> _load() async {
    final source = PurchaseLocalDataSource(ref.read(databaseProvider));
    try {
      if (_viewing) {
        final detail = await source.loadDetail(widget.purchaseId!);
        if (!mounted) return;
        setState(() {
          _saved = detail;
          _loading = false;
        });
        return;
      }
      final catalog = await source.loadCatalog();
      if (widget.editing && widget.purchaseId != null) {
        final detail = await source.loadDetail(widget.purchaseId!);
        if (!mounted) return;
        _date = DateTime(detail.purchasedAt.year, detail.purchasedAt.month, detail.purchasedAt.day);
        _pickedSupplier = detail.supplierName;
        final byId = {for (final product in catalog.products) product.id: product};
        for (final line in detail.lines) {
          final product = byId[line.productId];
          if (product == null) continue;
          _lines.add(
            _DraftLine(
              product: product,
              qty: TextEditingController(text: _plain(line.qty)),
              cost: TextEditingController(text: _plain(line.unitCost)),
              pieces: TextEditingController(text: line.packSize > 1 ? _plain(line.packSize) : ''),
              asPack: line.packSize > 1,
            ),
          );
        }
      } else {
        _applySeeds(catalog);
      }
      if (!mounted) return;
      setState(() {
        _catalog = catalog;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = 'အဝယ်အသေးစိတ်ဖွင့်မရပါ။';
      });
    }
  }

  @override
  void dispose() {
    _search.dispose();
    _supplier.dispose();
    _newName.dispose();
    _newCost.dispose();
    _newPieces.dispose();
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegisterBar(showGear: true),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadError != null
              ? Center(child: Text(_loadError!))
              : _viewing
                  ? _SavedPurchase(detail: _saved!, onRepurchase: _queueRepurchase)
                  : _editor(),
    );
  }

  Widget _editor() {
    final catalog = _catalog!;
    final query = _latin(_search.text.trim());
    final products = catalog.products.where((product) {
      final categoryOk = _categoryId == null || product.categoryId == _categoryId;
      final queryOk = query.isEmpty || product.nameMm.contains(query) || (product.barcode ?? '').contains(query);
      return categoryOk && queryOk;
    }).toList();
    final total = _lines.fold<double>(0, (sum, line) {
      final qty = MyanmarDigits.parse(line.qty.text) ?? 0;
      final cost = MyanmarDigits.parse(line.cost.text) ?? 0;
      return sum + qty * cost;
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.editing ? 'အဝယ်ပြင်မည်' : 'အဝယ်အသစ်', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined, size: 18),
                label: Text('ရက်စွဲ  ${_day(_date)}'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _supplier,
            onChanged: (_) => setState(() => _pickedSupplier = null),
            decoration: _input(context,'ကုန်သွင်းသူ၊ မထည့်လည်းရသည်'),
          ),
          if (catalog.suppliers.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final name in catalog.suppliers)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(name),
                        selected: _supplier.text.isEmpty && _pickedSupplier == name,
                        selectedColor: KasaColors.brown,
                        labelStyle: TextStyle(color: _supplier.text.isEmpty && _pickedSupplier == name ? Colors.white : KasaColors.ink),
                        onSelected: (_) => setState(() {
                          _supplier.clear();
                          _pickedSupplier = name;
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final sideBySide = constraints.maxWidth >= 980;
                final picker = _creating
                    ? _NewBrand(
                        categories: catalog.categories,
                        units: catalog.units,
                        categoryId: _newCategoryId,
                        unitId: _newUnitId,
                        asPack: _newAsPack,
                        name: _newName,
                        cost: _newCost,
                        pieces: _newPieces,
                        saving: _adding,
                        error: _error,
                        onCategory: (id) => setState(() {
                          _newCategoryId = id;
                          _newUnitId = _defaultUnit(id);
                        }),
                        onUnit: (id) => setState(() => _newUnitId = id),
                        onPack: (value) => setState(() => _newAsPack = value),
                        onCancel: () => setState(() {
                          _creating = false;
                          _error = null;
                        }),
                        onAdd: _addNewBrand,
                      )
                    : _Picker(
                        search: _search,
                        categories: catalog.categories,
                        categoryId: _categoryId,
                        products: products,
                        onQuery: (_) => setState(() {}),
                        onSubmit: () => _submitSearch(catalog.products),
                        onCategory: (id) => setState(() => _categoryId = id),
                        onProduct: _addProduct,
                        onNew: _startNewBrand,
                      );
                final lines = _Lines(
                  lines: _lines,
                  total: total,
                  error: _error,
                  saving: _saving,
                  onChanged: () => setState(() {}),
                  onRemove: _remove,
                  onSave: _save,
                );
                if (sideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 2, child: picker),
                      const SizedBox(width: 16),
                      Expanded(flex: 3, child: lines),
                    ],
                  );
                }
                return Column(
                  children: [
                    SizedBox(height: 280, child: picker),
                    const SizedBox(height: 12),
                    Expanded(child: lines),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _applySeeds(PurchaseCatalog catalog) {
    final byId = {for (final product in catalog.products) product.id: product};
    for (final seed in widget.seeds) {
      final product = byId[seed.productId];
      if (product == null) continue;
      final stored = seed.packSize > 1 ? seed.packSize : (product.packSize != null && product.packSize! > 1 ? product.packSize! : null);
      final asPack = seed.asPack || seed.packSize > 1;
      _lines.add(
        _DraftLine(
          product: product,
          qty: TextEditingController(text: _plain(seed.qty)),
          cost: TextEditingController(text: _listedCost(product, asPack: asPack)),
          pieces: TextEditingController(text: stored == null ? '' : _plain(stored)),
          asPack: asPack,
        ),
      );
    }
  }

  Future<void> _queueRepurchase() async {
    final detail = _saved;
    if (detail == null || detail.lines.isEmpty) return;
    final source = RepurchaseLocalDataSource(ref.read(databaseProvider));
    final repurchaseId = await source.ensureOpen();
    for (final line in detail.lines) {
      await source.add(
        repurchaseId: repurchaseId,
        productId: line.productId,
        qty: line.packSize > 1 ? 0 : line.qty,
        packQty: line.packSize > 1 ? line.qty : 0,
        packSize: line.packSize,
      );
    }
    ref.invalidate(repurchaseListProvider);
    if (!mounted) return;
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => RepurchaseDetailScreen(repurchaseId: repurchaseId)));
  }

  void _startNewBrand() {
    final categoryId = _categoryId ?? (_catalog!.categories.isEmpty ? null : _catalog!.categories.first.id);
    setState(() {
      _creating = true;
      _newCategoryId = categoryId;
      _newUnitId = _defaultUnit(categoryId);
      _newAsPack = false;
      _error = null;
    });
  }

  String? _defaultUnit(String? categoryId) {
    final catalog = _catalog;
    if (catalog == null || catalog.units.isEmpty) return null;
    if (categoryId != null) {
      for (final product in catalog.products) {
        if (product.categoryId != categoryId) continue;
        for (final unit in catalog.units) {
          if (unit.nameMm == product.unitMm) return unit.id;
        }
      }
    }
    return catalog.units.first.id;
  }

  Future<void> _addNewBrand() async {
    final categoryId = _newCategoryId;
    final unitId = _newUnitId;
    final cost = MyanmarDigits.parse(_newCost.text);
    final pieces = MyanmarDigits.parse(_newPieces.text);
    if (categoryId == null) {
      setState(() => _error = 'အမျိုးအစားရွေးပါ။');
      return;
    }
    if (_newName.text.trim().isEmpty) {
      setState(() => _error = 'အမည်ဖြည့်ပါ။');
      return;
    }
    if (unitId == null) {
      setState(() => _error = 'ယူနစ်ရွေးပါ။');
      return;
    }
    if (cost == null || cost <= 0) {
      setState(() => _error = 'အဝယ်ဈေးဖြည့်ပါ။');
      return;
    }
    if (_newAsPack && (pieces == null || pieces <= 1)) {
      setState(() => _error = '၁ ဖာတွင် အရေအတွက်ဖြည့်ပါ။');
      return;
    }
    setState(() {
      _adding = true;
      _error = null;
    });
    final result = await PurchaseLocalDataSource(ref.read(databaseProvider)).createProduct(name: _newName.text, categoryId: categoryId, unitId: unitId);
    if (!mounted) return;
    if (result.product == null) {
      setState(() {
        _adding = false;
        _error = result.error;
      });
      return;
    }
    final catalog = _catalog!;
    final products = [
      for (final product in catalog.products)
        if (product.id != result.product!.id) product,
      result.product!,
    ]..sort((a, b) => a.nameMm.compareTo(b.nameMm));
    _catalog = PurchaseCatalog(categories: catalog.categories, products: products, suppliers: catalog.suppliers, units: catalog.units);
    _addProduct(result.product!, asPack: _newAsPack, cost: _plain(cost), pieces: _newAsPack ? _plain(pieces!) : '');
    _newName.clear();
    _newCost.clear();
    _newPieces.clear();
    setState(() {
      _adding = false;
      _creating = false;
      _newAsPack = false;
    });
    ref.invalidate(productListProvider);
  }

  void _addProduct(PurchaseProduct product, {bool asPack = false, String? cost, String? pieces}) {
    final existing = _lines.where((line) => line.product.id == product.id);
    if (existing.isNotEmpty) {
      final line = existing.first;
      final qty = (MyanmarDigits.parse(line.qty.text) ?? 0) + 1;
      line.qty.text = _plain(qty);
      setState(() {});
      return;
    }
    setState(() {
      _lines.add(
        _DraftLine(
          product: product,
          qty: TextEditingController(text: '1'),
          cost: TextEditingController(text: cost ?? _listedCost(product, asPack: asPack)),
          pieces: TextEditingController(text: pieces ?? (product.packSize != null && product.packSize! > 1 ? _plain(product.packSize!) : '')),
          asPack: asPack,
        ),
      );
    });
  }

  void _remove(_DraftLine line) {
    line.dispose();
    setState(() => _lines.remove(line));
  }

  void _submitSearch(List<PurchaseProduct> products) {
    final query = _latin(_search.text.trim());
    if (query.isEmpty) return;
    final matches = products.where((product) => product.barcode == query);
    if (matches.length == 1) {
      _addProduct(matches.first);
      _search.clear();
      setState(() {});
    }
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(today.year, today.month, today.day),
    );
    if (picked == null) return;
    setState(() => _date = DateTime(picked.year, picked.month, picked.day));
  }

  Future<void> _save() async {
    final staff = ref.read(sessionProvider);
    if (staff == null) return;
    final lines = <NewPurchaseLine>[];
    for (final line in _lines) {
      final qty = MyanmarDigits.parse(line.qty.text);
      final cost = MyanmarDigits.parse(line.cost.text);
      if (qty == null || qty <= 0 || cost == null) {
        setState(() => _error = 'အရေအတွက်နှင့် အဝယ်ဈေးဖြည့်ပါ။');
        return;
      }
      var packSize = 1.0;
      if (line.asPack) {
        final pieces = MyanmarDigits.parse(line.pieces.text);
        if (pieces == null || pieces <= 1) {
          setState(() => _error = '၁ ဖာတွင် အရေအတွက်ဖြည့်ပါ။');
          return;
        }
        packSize = pieces;
      }
      lines.add(NewPurchaseLine(productId: line.product.id, qty: qty, unitCost: cost, packSize: packSize));
    }
    if (lines.isEmpty) {
      setState(() => _error = 'ကုန်ပစ္စည်းတစ်ခုထည့်ပါ။');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final typed = _supplier.text.trim();
    final draft = NewPurchase(
      staffId: staff.id,
      purchasedAt: _date,
      supplierName: typed.isNotEmpty ? typed : _pickedSupplier,
      lines: lines,
    );
    final source = PurchaseLocalDataSource(ref.read(databaseProvider));
    final result = widget.editing && widget.purchaseId != null ? await source.update(widget.purchaseId!, draft) : await source.save(draft);
    if (!mounted) return;
    if (result.error != null) {
      setState(() {
        _saving = false;
        _error = result.error;
      });
      return;
    }
    final repurchases = RepurchaseLocalDataSource(ref.read(databaseProvider));
    final finishedRepurchase = widget.repurchaseId != null && result.id != null;
    if (finishedRepurchase) {
      await repurchases.removeDocument(widget.repurchaseId!);
      if (!mounted) return;
      ref.invalidate(repurchaseListProvider);
      ref.invalidate(repurchaseSheetProvider(widget.repurchaseId!));
    }
    ref.invalidate(purchaseListProvider);
    ref.invalidate(purchasePriceHistoryProvider);
    ref.invalidate(profitReportProvider);
    ref.invalidate(productListProvider);
    ref.invalidate(saleCatalogProvider);
    ref.invalidate(pendingCountProvider);
    Navigator.pop(context, finishedRepurchase);
  }
}

class _SavedPurchase extends StatelessWidget {
  const _SavedPurchase({required this.detail, required this.onRepurchase});

  final PurchaseDetail detail;
  final VoidCallback onRepurchase;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      children: [
        Text(purchaseListLabel(detail.purchaseNo), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('${_day(detail.purchasedAt)}  ·  ${detail.supplierName ?? '—'}', style: const TextStyle(color: KasaColors.muted)),
        if (detail.lines.isNotEmpty) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: onRepurchase,
              style: FilledButton.styleFrom(backgroundColor: KasaColors.brown),
              child: const Text('ပြန်ဝယ်စာရင်းသို့'),
            ),
          ),
        ],
        if (detail.pending) Padding(padding: const EdgeInsets.only(top: 8), child: Text('မပို့ရသေး', style: TextStyle(color: KasaColors.brown))),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(flex: 3, child: Text('ကုန်ပစ္စည်း', style: _detailHeader)),
            Expanded(flex: 2, child: Text('ဝယ်ပုံ', style: _detailHeader)),
            Expanded(flex: 3, child: Text('အရေအတွက်', style: _detailHeader)),
            Expanded(flex: 2, child: Text('အဝယ်ဈေး', style: _detailHeader)),
            Expanded(flex: 2, child: Text('ငွေပမာဏ', textAlign: TextAlign.right, style: _detailHeader)),
          ],
        ),
        const SizedBox(height: 8),
        if (detail.lines.isEmpty) const Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)),
        for (final line in detail.lines)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text(line.nameMm.isEmpty ? '—' : line.nameMm, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                Expanded(flex: 2, child: Text(line.packSize > 1 ? 'ဖာ' : '${line.unitMm}ချင်း')),
                Expanded(flex: 3, child: Text(_boughtQty(line), style: const TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('${money(line.unitCost)} ကျပ်')),
                Expanded(flex: 2, child: Text('${money(line.lineTotal)} ကျပ်', textAlign: TextAlign.right)),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Text('${money(detail.total)} ကျပ်', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

const _detailHeader = TextStyle(color: KasaColors.muted, fontSize: 13, fontWeight: FontWeight.w600);

class _Picker extends StatelessWidget {
  const _Picker({
    required this.search,
    required this.categories,
    required this.categoryId,
    required this.products,
    required this.onQuery,
    required this.onSubmit,
    required this.onCategory,
    required this.onProduct,
    required this.onNew,
  });

  final TextEditingController search;
  final List<PurchaseCategory> categories;
  final String? categoryId;
  final List<PurchaseProduct> products;
  final ValueChanged<String> onQuery;
  final VoidCallback onSubmit;
  final ValueChanged<String?> onCategory;
  final ValueChanged<PurchaseProduct> onProduct;
  final VoidCallback onNew;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: search,
                onChanged: onQuery,
                onSubmitted: (_) => onSubmit(),
                decoration: _input(context,'ကုန်ပစ္စည်း သို့ ဘားကုဒ်').copyWith(prefixIcon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: onNew,
              style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18)),
              icon: const Icon(Icons.add),
              label: const Text('အသစ်'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _chip('အားလုံး', categoryId == null, () => onCategory(null)),
              for (final category in categories) _chip(category.nameMm, categoryId == category.id, () => onCategory(category.id)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: products.isEmpty
              ? const Center(child: Text('ကုန်ပစ္စည်းမရှိပါ။', style: TextStyle(color: KasaColors.muted)))
              : ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Material(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => onProduct(product),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.nameMm, style: const TextStyle(fontWeight: FontWeight.w700)),
                                    Text(product.unitMm, style: const TextStyle(color: KasaColors.muted, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Text('${money(product.cost)} ကျပ်', style: const TextStyle(color: KasaColors.muted)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: KasaColors.brown,
        labelStyle: TextStyle(color: selected ? Colors.white : KasaColors.ink),
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _NewBrand extends StatelessWidget {
  const _NewBrand({
    required this.categories,
    required this.units,
    required this.categoryId,
    required this.unitId,
    required this.asPack,
    required this.name,
    required this.cost,
    required this.pieces,
    required this.saving,
    required this.error,
    required this.onCategory,
    required this.onUnit,
    required this.onPack,
    required this.onCancel,
    required this.onAdd,
  });

  final List<PurchaseCategory> categories;
  final List<PurchaseUnit> units;
  final String? categoryId;
  final String? unitId;
  final bool asPack;
  final TextEditingController name;
  final TextEditingController cost;
  final TextEditingController pieces;
  final bool saving;
  final String? error;
  final ValueChanged<String?> onCategory;
  final ValueChanged<String> onUnit;
  final ValueChanged<bool> onPack;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final unitName = units.where((unit) => unit.id == unitId).map((unit) => unit.nameMm).firstOrNull ?? '';
    return ListView(
      children: [
        Row(
          children: [
            const Expanded(child: Text('ကုန်ပစ္စည်းအသစ်', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
            TextButton(onPressed: saving ? null : onCancel, child: const Text('ပယ်ဖျက်မည်')),
          ],
        ),
        const SizedBox(height: 8),
        const Text('အမျိုးအစား', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: KasaColors.line)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: categoryId,
                isExpanded: true,
                hint: const Text('ရွေးပါ'),
                items: [for (final category in categories) DropdownMenuItem(value: category.id, child: Text(category.nameMm))],
                onChanged: onCategory,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text('အမည်', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextField(controller: name, decoration: _input(context,'အမှတ်တံဆိပ်')),
        const SizedBox(height: 12),
        const Text('ယူနစ်', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final unit in units)
              ChoiceChip(
                label: Text(unit.nameMm),
                selected: unit.id == unitId,
                selectedColor: KasaColors.brown,
                labelStyle: TextStyle(color: unit.id == unitId ? Colors.white : KasaColors.ink),
                onSelected: (_) => onUnit(unit.id),
              ),
          ],
        ),
        const SizedBox(height: 12),
        const Text('ဝယ်ပုံ', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ChoiceChip(
              label: Text(unitName.isEmpty ? 'ချင်း' : '$unitNameချင်း'),
              selected: !asPack,
              selectedColor: KasaColors.brown,
              labelStyle: TextStyle(color: asPack ? KasaColors.ink : Colors.white),
              onSelected: (_) => onPack(false),
            ),
            ChoiceChip(
              label: const Text('ဖာ'),
              selected: asPack,
              selectedColor: KasaColors.brown,
              labelStyle: TextStyle(color: asPack ? Colors.white : KasaColors.ink),
              onSelected: (_) => onPack(true),
            ),
            if (asPack) ...[
              const Text('၁ ဖာ ='),
              SizedBox(
                width: 72,
                child: TextField(
                  controller: pieces,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                  decoration: _input(context,unitName),
                ),
              ),
              Text(unitName),
            ],
          ],
        ),
        const SizedBox(height: 12),
        const Text('အဝယ်ဈေး', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        TextField(
          controller: cost,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
          decoration: _input(context,asPack ? 'ကျပ် / ဖာ' : 'ကျပ်'),
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(error!, style: const TextStyle(color: KasaColors.danger)),
        ],
        const SizedBox(height: 12),
        FilledButton(
          onPressed: saving ? null : onAdd,
          style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
          child: Text(saving ? 'ထည့်နေသည်' : 'စာရင်းသို့ထည့်မည်'),
        ),
      ],
    );
  }
}

class _Lines extends StatelessWidget {
  const _Lines({
    required this.lines,
    required this.total,
    required this.error,
    required this.saving,
    required this.onChanged,
    required this.onRemove,
    required this.onSave,
  });

  final List<_DraftLine> lines;
  final double total;
  final String? error;
  final bool saving;
  final VoidCallback onChanged;
  final ValueChanged<_DraftLine> onRemove;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: KasaColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: KasaColors.line)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('စာရင်း', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: lines.isEmpty
                  ? const Center(child: Text('ကုန်ပစ္စည်းကို နှိပ်ပါ။', style: TextStyle(color: KasaColors.muted)))
                  : ListView.separated(
                      itemCount: lines.length,
                      separatorBuilder: (context, index) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final line = lines[index];
                        final qty = MyanmarDigits.parse(line.qty.text) ?? 0;
                        final cost = MyanmarDigits.parse(line.cost.text) ?? 0;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(line.product.nameMm, style: const TextStyle(fontWeight: FontWeight.w700))),
                                IconButton(onPressed: () => onRemove(line), icon: const Icon(Icons.close, size: 18)),
                              ],
                            ),
                            Wrap(
                              spacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ChoiceChip(
                                  label: Text('${line.product.unitMm}ချင်း'),
                                  selected: !line.asPack,
                                  selectedColor: KasaColors.brown,
                                  labelStyle: TextStyle(color: line.asPack ? KasaColors.ink : Colors.white),
                                  onSelected: (_) {
                                    line.asPack = false;
                                    line.cost.text = _listedCost(line.product, asPack: false);
                                    onChanged();
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('ဖာ'),
                                  selected: line.asPack,
                                  selectedColor: KasaColors.brown,
                                  labelStyle: TextStyle(color: line.asPack ? Colors.white : KasaColors.ink),
                                  onSelected: (_) {
                                    line.asPack = true;
                                    if (line.pieces.text.trim().isEmpty && line.product.packSize != null && line.product.packSize! > 1) {
                                      line.pieces.text = _plain(line.product.packSize!);
                                    }
                                    line.cost.text = _listedCost(line.product, asPack: true);
                                    onChanged();
                                  },
                                ),
                                if (line.asPack) ...[
                                  const Text('၁ ဖာ ='),
                                  SizedBox(
                                    width: 72,
                                    child: TextField(
                                      controller: line.pieces,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                                      onChanged: (_) => onChanged(),
                                      decoration: _input(context,line.product.unitMm),
                                    ),
                                  ),
                                  Text(line.product.unitMm),
                                ],
                              ],
                            ),
                            if (line.asPack && (MyanmarDigits.parse(line.pieces.text) ?? 0) > 1)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'စတော့သို့ ${_plain(qty * (MyanmarDigits.parse(line.pieces.text) ?? 0))} ${line.product.unitMm}',
                                  style: const TextStyle(color: KasaColors.muted, fontSize: 12),
                                ),
                              ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final next = (MyanmarDigits.parse(line.qty.text) ?? 0) - 1;
                                    if (next <= 0) {
                                      onRemove(line);
                                      return;
                                    }
                                    line.qty.text = _plain(next);
                                    onChanged();
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                SizedBox(
                                  width: 64,
                                  child: TextField(
                                    controller: line.qty,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                                    onChanged: (_) => onChanged(),
                                    decoration: _input(context,line.asPack ? 'ဖာ' : line.product.unitMm),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final next = (MyanmarDigits.parse(line.qty.text) ?? 0) + 1;
                                    line.qty.text = _plain(next);
                                    onChanged();
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                                const SizedBox(width: 8),
                                Text(line.asPack ? 'အဝယ်ဈေး / ဖာ' : 'အဝယ်ဈေး / ${line.product.unitMm}'),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: line.cost,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                                    onChanged: (_) => onChanged(),
                                    decoration: _input(context,'ကျပ်'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text('${money(qty * cost)} ကျပ်'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('စုစုပေါင်း', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                Text('${money(total)} ကျပ်', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 32)),
              ],
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(error!, style: const TextStyle(color: KasaColors.danger)),
            ],
            const SizedBox(height: 8),
            FilledButton(
              onPressed: saving ? null : onSave,
              style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(saving ? 'သိမ်းနေသည်' : 'သိမ်းမည်'),
            ),
            const SizedBox(height: 4),
            const Text('အော့ဖ်လိုင်းတွင်လည်း သိမ်းနိုင်သည်', textAlign: TextAlign.center, style: TextStyle(color: KasaColors.muted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

String _latin(String input) {
  const myanmar = '၀၁၂၃၄၅၆၇၈၉';
  const latin = '0123456789';
  return input.split('').map((char) {
    final index = myanmar.indexOf(char);
    return index >= 0 ? latin[index] : char;
  }).join();
}

String _day(DateTime value) => '${value.day}/${value.month}/${value.year}';

String _boughtQty(PurchaseLineView line) {
  if (line.packSize > 1) return '${_plain(line.qty)} ဖာ · ၁ ဖာ = ${_plain(line.packSize)} ${line.unitMm}';
  return '${_plain(line.qty)} ${line.unitMm}';
}

String _listedCost(PurchaseProduct product, {required bool asPack}) {
  final listed = asPack ? product.packBuyPrice : product.buyPrice;
  if (listed != null && listed > 0) return _plain(listed);
  if (!asPack && product.cost > 0) return _plain(product.cost);
  return '';
}

String _plain(double value) {
  if (value == value.roundToDouble()) return value.round().toString();
  return value.toString();
}

InputDecoration _input(BuildContext context, String hint) {
  return InputDecoration(
    hintText: hint,
    isDense: true,
    filled: true,
    fillColor: Theme.of(context).cardColor,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
  );
}
