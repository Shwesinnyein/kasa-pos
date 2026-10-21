import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/format/money.dart';
import '../../../core/myanmar/myanmar_digits.dart';
import '../../../core/providers.dart';
import '../../../core/widgets/register_bar.dart';
import '../../session/session_controller.dart';
import '../data/sale_local_data_source.dart';
import '../domain/entities/sale_catalog.dart';
import '../domain/entities/sale_record.dart';
import '../domain/sale_math.dart';
import 'sale_controller.dart';

class SaleScreen extends ConsumerStatefulWidget {
  const SaleScreen({super.key, this.saleId});

  final String? saleId;

  @override
  ConsumerState<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends ConsumerState<SaleScreen> {
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  final _discount = TextEditingController(text: '0');
  final _paid = TextEditingController(text: '0');
  var _editReady = false;
  String? _editError;

  @override
  void initState() {
    super.initState();
    if (widget.saleId == null) {
      _editReady = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadSale());
    }
  }

  Future<void> _loadSale() async {
    final sale = await SaleLocalDataSource(ref.read(databaseProvider)).loadDetail(widget.saleId!);
    if (!mounted) return;
    if (sale == null) {
      setState(() {
        _editReady = true;
        _editError = 'အရောင်းမရှိပါ။';
      });
      return;
    }
    ref.read(saleControllerProvider.notifier).beginEdit(sale);
    _discount.text = _plain(sale.discount);
    _paid.text = _plain(sale.paidAmount);
    setState(() => _editReady = true);
  }

  @override
  void dispose() {
    if (widget.saleId != null) {
      ref.read(saleControllerProvider.notifier).clearCart();
    }
    _search.dispose();
    _searchFocus.dispose();
    _discount.dispose();
    _paid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(saleCatalogProvider);
    final sale = ref.watch(saleControllerProvider);
    final owner = ref.watch(sessionProvider)?.isOwner ?? false;

    return Scaffold(
      appBar: RegisterBar(showGear: owner),
      body: !_editReady
          ? const Center(child: CircularProgressIndicator())
          : _editError != null
              ? Center(child: Text(_editError!))
              : catalog.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('ကုန်ပစ္စည်းဖွင့်မရပါ။ $error')),
                  data: (data) => _SaleBody(
                    catalog: data,
                    sale: sale,
                    search: _search,
                    searchFocus: _searchFocus,
                    discount: _discount,
                    paid: _paid,
                    onClear: () {
                      _search.clear();
                      _discount.text = '0';
                      _paid.text = '0';
                      final controller = ref.read(saleControllerProvider.notifier);
                      if (widget.saleId != null) {
                        controller.clearLines();
                      } else {
                        controller.clearCart();
                      }
                    },
                  ),
                ),
    );
  }
}

class _SaleBody extends ConsumerWidget {
  const _SaleBody({
    required this.catalog,
    required this.sale,
    required this.search,
    required this.searchFocus,
    required this.discount,
    required this.paid,
    required this.onClear,
  });

  final SaleCatalog catalog;
  final SaleUiState sale;
  final TextEditingController search;
  final FocusNode searchFocus;
  final TextEditingController discount;
  final TextEditingController paid;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(saleControllerProvider.notifier);
    final byId = {for (final product in catalog.products) product.id: product};
    final filtered = catalog.products.where((product) {
      final categoryOk = sale.categoryId == null || product.categoryId == sale.categoryId;
      final query = sale.query.trim();
      if (!categoryOk) return false;
      if (query.isEmpty) return true;
      return product.nameMm.contains(query) || (product.barcode?.contains(query) ?? false);
    }).toList();
    final pageCount = filtered.isEmpty ? 1 : (filtered.length / sale.pageSize).ceil();
    final page = sale.page.clamp(0, pageCount - 1);
    final visible = filtered.skip(page * sale.pageSize).take(sale.pageSize).toList();
    final priced = [
      for (final line in sale.lines)
        if (byId[line.productId] != null || line.unitPrice != null) (price: _charged(line, byId[line.productId]), qty: line.qty),
    ];
    final subtotal = SaleMath.subtotal(priced);
    final discountAmount = SaleMath.discount(subtotal: subtotal, input: sale.discountInput, mode: sale.discountMode);
    final total = SaleMath.total(subtotal: subtotal, discount: discountAmount);
    final change = SaleMath.change(total: total, paid: sale.paidAmount, payment: sale.payment);

    return Row(
      children: [
        _Categories(
          categories: catalog.categories,
          selectedId: sale.categoryId,
          onSelected: controller.selectCategory,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 12),
            child: Column(
              children: [
                TextField(
                  controller: search,
                  focusNode: searchFocus,
                  onChanged: controller.setQuery,
                  onSubmitted: (_) => controller.submitSearch(catalog.products),
                  decoration: InputDecoration(
                    hintText: 'ကုန်ပစ္စည်းရှာရန်...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      tooltip: 'ဘားကုဒ်',
                      onPressed: searchFocus.requestFocus,
                      icon: const Icon(Icons.barcode_reader),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: KasaColors.line)),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    itemCount: visible.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisExtent: 168,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = visible[index];
                      return _ProductCard(product: product, onTap: () => controller.addProduct(product));
                    },
                  ),
                ),
                const SizedBox(height: 8),
                _Pager(
                  page: page,
                  pageCount: pageCount,
                  pageSize: sale.pageSize,
                  onPage: controller.setPage,
                  onPageSize: controller.setPageSize,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 420,
          child: _Cart(
            sale: sale,
            byId: byId,
            subtotal: subtotal,
            discountAmount: discountAmount,
            total: total,
            change: change,
            discount: discount,
            paid: paid,
            onClear: onClear,
            onSave: sale.lines.isEmpty || sale.saving
                ? null
                : () async {
                    final editing = sale.editingSaleId != null;
                    final saved = await controller.save(catalog.products);
                    if (!saved || !context.mounted) return;
                    onClear();
                    if (editing) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
            onPrint: sale.canPrint
                ? () => _showReceipt(
                      context,
                      saleNo: sale.savedSaleNo!,
                      lines: sale.lines,
                      byId: byId,
                      subtotal: subtotal,
                      discount: discountAmount,
                      total: total,
                      payment: sale.payment,
                      paid: sale.paidAmount,
                      change: change,
                    )
                : null,
          ),
        ),
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({required this.categories, required this.selectedId, required this.onSelected});

  final List<SaleCategory> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      color: const Color(0xFFF3EEE8),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Text('အမျိုးအစား', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          _CategoryTile(label: 'အားလုံး', icon: Icons.grid_view_rounded, selected: selectedId == null, onTap: () => onSelected(null)),
          for (final category in categories)
            _CategoryTile(
              label: category.nameMm,
              icon: _categoryIcon(category.id),
              selected: selectedId == category.id,
              onTap: () => onSelected(category.id),
            ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? KasaColors.brown : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 18, color: selected ? Colors.white : KasaColors.brown),
                const SizedBox(width: 8),
                Expanded(child: Text(label, style: TextStyle(color: selected ? Colors.white : KasaColors.ink, fontWeight: FontWeight.w500))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final SaleProduct product;
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(child: Icon(_categoryIcon(product.categoryId), size: 36, color: KasaColors.brown)),
              ),
              Text(product.nameMm, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text('${money(product.price)} ကျပ် / ${product.unitMm}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              if (product.previousPrice != null && product.previousPrice! > 0 && product.previousPrice != product.price)
                Text('ယခင် ${money(product.previousPrice!)}', style: const TextStyle(color: KasaColors.muted, fontSize: 11, decoration: TextDecoration.lineThrough)),
              if (product.hasPack) Text('${money(product.packPrice!)} ကျပ် / ဖာ', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              if (product.hasPack && product.previousPackPrice != null && product.previousPackPrice! > 0 && product.previousPackPrice != product.packPrice)
                Text('ယခင် ${money(product.previousPackPrice!)} / ဖာ', style: const TextStyle(color: KasaColors.muted, fontSize: 11, decoration: TextDecoration.lineThrough)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cart extends ConsumerWidget {
  const _Cart({
    required this.sale,
    required this.byId,
    required this.subtotal,
    required this.discountAmount,
    required this.total,
    required this.change,
    required this.discount,
    required this.paid,
    required this.onClear,
    required this.onSave,
    required this.onPrint,
  });

  final SaleUiState sale;
  final Map<String, SaleProduct> byId;
  final double subtotal;
  final double discountAmount;
  final double total;
  final double change;
  final TextEditingController discount;
  final TextEditingController paid;
  final VoidCallback onClear;
  final VoidCallback? onSave;
  final VoidCallback? onPrint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(saleControllerProvider.notifier);
    return ColoredBox(
      color: const Color(0xFFF8F4EF),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart_outlined, color: KasaColors.brown),
                const SizedBox(width: 8),
                Text(
                  sale.editingSaleNo == null ? 'ခြင်းတောင်း (${sale.lines.length})' : '${saleListLabel(sale.editingSaleNo!)} (${sale.lines.length})',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const Spacer(),
                TextButton.icon(onPressed: sale.lines.isEmpty ? null : onClear, icon: const Icon(Icons.delete_outline), label: const Text('အားလုံးဖျက်မည်')),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Expanded(flex: 4, child: Text('ကုန်ပစ္စည်း', style: TextStyle(color: KasaColors.muted, fontSize: 12))),
                Expanded(child: Text('ဈေး', style: TextStyle(color: KasaColors.muted, fontSize: 12))),
                Expanded(flex: 2, child: Text('အရေအတွက်', style: TextStyle(color: KasaColors.muted, fontSize: 12))),
                Expanded(child: Text('စုစုပေါင်း', textAlign: TextAlign.right, style: TextStyle(color: KasaColors.muted, fontSize: 12))),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  for (final line in sale.lines)
                    if (byId[line.productId] != null || line.unitPrice != null)
                      _CartLine(
                        name: byId[line.productId]?.nameMm ?? line.nameMm ?? '',
                        unitMm: byId[line.productId]?.unitMm ?? line.unitMm ?? '',
                        price: _charged(line, byId[line.productId]),
                        qty: line.qty,
                        asPack: line.asPack,
                        hasPack: byId[line.productId]?.hasPack ?? false,
                        onMinus: () => controller.setQty(line.productId, line.qty - 1, asPack: line.asPack),
                        onPlus: () => controller.setQty(line.productId, line.qty + 1, asPack: line.asPack),
                        onRemove: () => controller.remove(line.productId, asPack: line.asPack),
                        onPack: (asPack) => controller.setPack(line.productId, asPack: asPack),
                      ),
                ],
              ),
            ),
            Row(
              children: [
                const Text('လျှော့ဈေး'),
                const SizedBox(width: 8),
                SizedBox(
                  width: 88,
                  child: TextField(
                    controller: discount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                    onChanged: (value) => controller.setDiscountInput(MyanmarDigits.parse(value) ?? 0),
                    decoration: InputDecoration(isDense: true, filled: true, fillColor: Theme.of(context).cardColor),
                  ),
                ),
                const SizedBox(width: 8),
                _ModeChip(label: 'ကျပ်', selected: sale.discountMode == DiscountMode.amount, onTap: () => controller.setDiscountMode(DiscountMode.amount)),
                const SizedBox(width: 4),
                _ModeChip(label: '%', selected: sale.discountMode == DiscountMode.percent, onTap: () => controller.setDiscountMode(DiscountMode.percent)),
              ],
            ),
            const SizedBox(height: 8),
            _AmountRow(label: 'ကုန်ပစ္စည်း စုစုပေါင်း', value: '${money(subtotal)} ကျပ်'),
            _AmountRow(label: 'လျှော့ဈေး', value: '${money(discountAmount)} ကျပ်'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text('စုစုပေါင်း', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                Text('${money(total)} ကျပ်', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 32)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('ငွေပေးချေမှု', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Row(
              children: [
                _PayChip(label: 'ငွေသား', icon: Icons.payments_outlined, selected: sale.payment == PaymentMethod.cash, onTap: () => controller.setPayment(PaymentMethod.cash)),
                const SizedBox(width: 6),
                _PayChip(label: 'ကတ်', icon: Icons.credit_card, selected: sale.payment == PaymentMethod.card, onTap: () => controller.setPayment(PaymentMethod.card)),
                const SizedBox(width: 6),
                _PayChip(label: 'ဘဏ်လွှဲ', icon: Icons.account_balance, selected: sale.payment == PaymentMethod.transfer, onTap: () => controller.setPayment(PaymentMethod.transfer)),
              ],
            ),
            if (sale.payment == PaymentMethod.cash) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('ရငွေ'),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: paid,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9၀-၉.]'))],
                      onChanged: (value) => controller.setPaidAmount(MyanmarDigits.parse(value) ?? 0),
                      decoration: InputDecoration(isDense: true, filled: true, fillColor: Theme.of(context).cardColor),
                    ),
                  ),
                  const Spacer(),
                  const Text('ပြန်အမ်း'),
                  const SizedBox(width: 8),
                  Text('${money(change)} ကျပ်', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: KasaColors.online)),
                ],
              ),
            ],
            if (sale.message != null) ...[
              const SizedBox(height: 8),
              Text(sale.message!, style: TextStyle(color: KasaColors.brown)),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton.icon(
                        onPressed: onSave,
                        style: FilledButton.styleFrom(backgroundColor: KasaColors.brown, padding: const EdgeInsets.symmetric(vertical: 14)),
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('သိမ်းမည်'),
                      ),
                      const SizedBox(height: 2),
                      const Text('အော့ဖ်လိုင်းတွင်လည်း သိမ်းနိုင်သည်', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: KasaColors.muted)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton.icon(
                        onPressed: onPrint,
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                        icon: const Icon(Icons.print_outlined),
                        label: const Text('ပရင့်ထုတ်မည်'),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sale.canPrint ? 'သိမ်းပြီးပါပြီ' : 'သိမ်းပြီးမှ အသုံးပြုနိုင်သည်',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11, color: KasaColors.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  const _CartLine({
    required this.name,
    required this.unitMm,
    required this.price,
    required this.qty,
    required this.asPack,
    required this.hasPack,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
    required this.onPack,
  });

  final String name;
  final String unitMm;
  final double price;
  final int qty;
  final bool asPack;
  final bool hasPack;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;
  final ValueChanged<bool> onPack;

  @override
  Widget build(BuildContext context) {
    final unit = asPack ? 'ဖာ' : unitMm;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.isEmpty ? '—' : name, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${money(price)} ကျပ် / $unit', style: const TextStyle(fontSize: 11, color: KasaColors.muted)),
                if (hasPack)
                  Wrap(
                    spacing: 4,
                    children: [
                      ChoiceChip(
                        label: Text(unitMm, style: const TextStyle(fontSize: 11)),
                        selected: !asPack,
                        visualDensity: VisualDensity.compact,
                        selectedColor: KasaColors.brown,
                        labelStyle: TextStyle(color: asPack ? KasaColors.ink : Colors.white, fontSize: 11),
                        onSelected: (_) => onPack(false),
                      ),
                      ChoiceChip(
                        label: const Text('ဖာ', style: TextStyle(fontSize: 11)),
                        selected: asPack,
                        visualDensity: VisualDensity.compact,
                        selectedColor: KasaColors.brown,
                        labelStyle: TextStyle(color: asPack ? Colors.white : KasaColors.ink, fontSize: 11),
                        onSelected: (_) => onPack(true),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Expanded(child: Text(money(price))),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _QtyButton(icon: Icons.remove, onTap: onMinus),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text('$qty')),
                _QtyButton(icon: Icons.add, onTap: onPlus),
              ],
            ),
          ),
          Expanded(child: Text(money(price * qty), textAlign: TextAlign.right)),
          IconButton(onPressed: onRemove, icon: const Icon(Icons.delete_outline, size: 18)),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: KasaColors.line), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 14),
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  const _Pager({required this.page, required this.pageCount, required this.pageSize, required this.onPage, required this.onPageSize});

  final int page;
  final int pageCount;
  final int pageSize;
  final ValueChanged<int> onPage;
  final ValueChanged<int> onPageSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: page > 0 ? () => onPage(page - 1) : null, icon: const Icon(Icons.chevron_left)),
        for (var index = 0; index < pageCount && index < 5; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: TextButton(
              onPressed: () => onPage(index),
              style: TextButton.styleFrom(backgroundColor: index == page ? KasaColors.brown : null, foregroundColor: index == page ? Colors.white : KasaColors.ink),
              child: Text('${index + 1}'),
            ),
          ),
        const Spacer(),
        const Text('တစ်မျက်နှာလျှင်'),
        const SizedBox(width: 8),
        DropdownButton<int>(
          value: pageSize,
          items: const [DropdownMenuItem(value: 20, child: Text('20'))],
          onChanged: (value) {
            if (value != null) onPageSize(value);
          },
        ),
      ],
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: KasaColors.brown,
      labelStyle: TextStyle(color: selected ? Colors.white : KasaColors.ink),
    );
  }
}

class _PayChip extends StatelessWidget {
  const _PayChip({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? KasaColors.brown : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Icon(icon, color: selected ? Colors.white : KasaColors.brown, size: 18),
                const SizedBox(height: 2),
                Text(label, style: TextStyle(color: selected ? Colors.white : KasaColors.ink, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: KasaColors.muted)),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }
}

double _charged(CartLine line, SaleProduct? product) {
  if (line.unitPrice != null) return line.unitPrice!;
  if (product == null) return 0;
  return product.unitPrice(asPack: line.asPack);
}

String _plain(double value) => value == value.roundToDouble() ? value.round().toString() : value.toString();

void _showReceipt(
  BuildContext context, {
  required String saleNo,
  required List<CartLine> lines,
  required Map<String, SaleProduct> byId,
  required double subtotal,
  required double discount,
  required double total,
  required PaymentMethod payment,
  required double paid,
  required double change,
}) {
  final method = switch (payment) {
    PaymentMethod.cash => 'ငွေသား',
    PaymentMethod.card => 'ကတ်',
    PaymentMethod.transfer => 'ဘဏ်လွှဲ',
  };
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('ဘောင်ချာ $saleNo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final line in lines)
            if (byId[line.productId] != null)
              Text('${byId[line.productId]!.nameMm}  ${line.qty} ${byId[line.productId]!.soldUnit(asPack: line.asPack)}  ${money(byId[line.productId]!.unitPrice(asPack: line.asPack) * line.qty)}'),
          const Divider(),
          Text('လျှော့ဈေး ${money(discount)}'),
          Text('စုစုပေါင်း ${money(total)} ကျပ်', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          Text(method),
          if (payment == PaymentMethod.cash) Text('ရငွေ ${money(paid)}  ပြန်အမ်း ${money(change)}'),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ပိတ်မည်'))],
    ),
  );
}

IconData _categoryIcon(String categoryId) {
  return switch (categoryId) {
    'cat-food' => Icons.ramen_dining,
    'cat-drink' => Icons.local_drink_outlined,
    'cat-clean' => Icons.cleaning_services_outlined,
    'cat-beauty' => Icons.spa_outlined,
    'cat-grocery' => Icons.shopping_basket_outlined,
    'cat-baby' => Icons.child_care,
    'cat-home' => Icons.home_outlined,
    _ => Icons.category_outlined,
  };
}
