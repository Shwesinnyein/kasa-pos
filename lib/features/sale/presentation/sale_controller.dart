import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../session/session_controller.dart';
import '../data/sale_local_data_source.dart';
import '../domain/entities/sale_catalog.dart';
import '../domain/entities/sale_record.dart';
import '../domain/repositories/sale_repository.dart';
import '../domain/sale_math.dart';

class SaleUiState {
  const SaleUiState({
    this.categoryId,
    this.query = '',
    this.lines = const [],
    this.discountMode = DiscountMode.amount,
    this.discountInput = 0,
    this.payment = PaymentMethod.cash,
    this.paidAmount = 0,
    this.page = 0,
    this.pageSize = 20,
    this.saving = false,
    this.savedSaleNo,
    this.savedFingerprint,
    this.message,
    this.editingSaleId,
    this.editingSaleNo,
  });

  final String? categoryId;
  final String query;
  final List<CartLine> lines;
  final DiscountMode discountMode;
  final double discountInput;
  final PaymentMethod payment;
  final double paidAmount;
  final int page;
  final int pageSize;
  final bool saving;
  final String? savedSaleNo;
  final String? savedFingerprint;
  final String? message;
  final String? editingSaleId;
  final String? editingSaleNo;

  bool get canPrint => savedSaleNo != null && savedFingerprint == _fingerprint;

  String get _fingerprint => [
        for (final line in lines) '${line.productId}:${line.qty}:${line.asPack}',
        discountMode.name,
        discountInput,
        payment.name,
        paidAmount,
      ].join('|');

  SaleUiState copyWith({
    String? categoryId,
    bool clearCategory = false,
    String? query,
    List<CartLine>? lines,
    DiscountMode? discountMode,
    double? discountInput,
    PaymentMethod? payment,
    double? paidAmount,
    int? page,
    int? pageSize,
    bool? saving,
    String? savedSaleNo,
    bool clearSaved = false,
    String? savedFingerprint,
    String? message,
    bool clearMessage = false,
    String? editingSaleId,
    String? editingSaleNo,
  }) {
    return SaleUiState(
      categoryId: clearCategory ? null : categoryId ?? this.categoryId,
      query: query ?? this.query,
      lines: lines ?? this.lines,
      discountMode: discountMode ?? this.discountMode,
      discountInput: discountInput ?? this.discountInput,
      payment: payment ?? this.payment,
      paidAmount: paidAmount ?? this.paidAmount,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      saving: saving ?? this.saving,
      savedSaleNo: clearSaved ? null : savedSaleNo ?? this.savedSaleNo,
      savedFingerprint: clearSaved ? null : savedFingerprint ?? this.savedFingerprint,
      message: clearMessage ? null : message ?? this.message,
      editingSaleId: editingSaleId ?? this.editingSaleId,
      editingSaleNo: editingSaleNo ?? this.editingSaleNo,
    );
  }
}

class SaleController extends Notifier<SaleUiState> {
  @override
  SaleUiState build() => const SaleUiState();

  void selectCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId, clearCategory: categoryId == null, page: 0);
  }

  void setQuery(String query) => state = state.copyWith(query: query, page: 0, clearMessage: true);

  void setPage(int page) => state = state.copyWith(page: page);

  void setPageSize(int pageSize) => state = state.copyWith(pageSize: pageSize, page: 0);

  void addProduct(SaleProduct product) {
    final lines = [...state.lines];
    final index = lines.indexWhere((line) => line.productId == product.id && !line.asPack);
    if (index >= 0) {
      lines[index] = lines[index].copyWith(qty: lines[index].qty + 1);
    } else {
      lines.add(CartLine(productId: product.id, qty: 1));
    }
    state = state.copyWith(lines: lines, clearSaved: true, clearMessage: true);
  }

  void setQty(String productId, int qty, {bool asPack = false}) {
    final lines = [
      for (final line in state.lines)
        if (line.productId != productId || line.asPack != asPack) line else if (qty > 0) line.copyWith(qty: qty),
    ];
    state = state.copyWith(lines: lines, clearSaved: true, clearMessage: true);
  }

  void setPack(String productId, {required bool asPack}) {
    final lines = [...state.lines];
    final index = lines.indexWhere((line) => line.productId == productId && line.asPack != asPack);
    if (index < 0) return;
    final current = lines.removeAt(index);
    final existing = lines.indexWhere((line) => line.productId == productId && line.asPack == asPack);
    if (existing >= 0) {
      lines[existing] = lines[existing].copyWith(qty: lines[existing].qty + current.qty);
    } else {
      lines.insert(index, current.copyWith(asPack: asPack, clearPrice: true));
    }
    state = state.copyWith(lines: lines, clearSaved: true, clearMessage: true);
  }

  void remove(String productId, {bool asPack = false}) => setQty(productId, 0, asPack: asPack);

  void clearCart() => state = const SaleUiState();

  void clearLines() {
    state = SaleUiState(editingSaleId: state.editingSaleId, editingSaleNo: state.editingSaleNo);
  }

  void beginEdit(SaleRecord sale) {
    state = SaleUiState(
      lines: [
        for (final line in sale.lines)
          CartLine(
            productId: line.productId,
            qty: line.qty.round() < 1 ? 1 : line.qty.round(),
            asPack: line.asPack,
            unitPrice: line.unitPrice,
            unitCost: line.unitCost,
            packSize: line.packSize <= 0 ? 1 : line.packSize,
            nameMm: line.nameMm,
            unitMm: line.unitMm,
          ),
      ],
      discountInput: sale.discount,
      payment: sale.payment,
      paidAmount: sale.paidAmount,
      editingSaleId: sale.id,
      editingSaleNo: sale.saleNo,
    );
  }

  void setDiscountMode(DiscountMode mode) => state = state.copyWith(discountMode: mode, clearSaved: true);

  void setDiscountInput(double value) => state = state.copyWith(discountInput: value, clearSaved: true);

  void setPayment(PaymentMethod payment) => state = state.copyWith(payment: payment, clearSaved: true);

  void setPaidAmount(double value) => state = state.copyWith(paidAmount: value, clearSaved: true);

  void submitSearch(List<SaleProduct> products) {
    final query = state.query.trim();
    if (query.isEmpty) return;
    final matches = products.where((product) => product.barcode == query);
    if (matches.length == 1) {
      addProduct(matches.first);
      state = state.copyWith(query: '');
    }
  }

  Future<bool> save(List<SaleProduct> products) async {
    final staff = ref.read(sessionProvider);
    if (staff == null || state.lines.isEmpty || state.saving) return false;
    final byId = {for (final product in products) product.id: product};
    final drafts = <SaleLineDraft>[
      for (final line in state.lines)
        if (_draft(line, byId[line.productId]) case final draft?) draft,
    ];
    if (drafts.isEmpty) {
      state = state.copyWith(saving: false, message: 'ကုန်ပစ္စည်းတစ်ခုထည့်ပါ။');
      return false;
    }
    final subtotal = drafts.fold<double>(0, (sum, line) => sum + line.unitPrice * line.qty);
    final discount = SaleMath.discount(subtotal: subtotal, input: state.discountInput, mode: state.discountMode);
    final total = SaleMath.total(subtotal: subtotal, discount: discount);
    final paid = state.payment == PaymentMethod.cash ? state.paidAmount : total;
    final editingId = state.editingSaleId;
    state = state.copyWith(saving: true, clearMessage: true);
    try {
      if (editingId != null) {
        final error = await SaleLocalDataSource(ref.read(databaseProvider)).update(
          editingId,
          SaleUpdate(discount: discount, payment: state.payment, paidAmount: paid, lines: drafts),
        );
        if (error != null) {
          state = state.copyWith(saving: false, message: error);
          return false;
        }
        ref.invalidate(saleDetailProvider(editingId));
      } else {
        await ref.read(saleRepositoryProvider).save(
              NewSale(
                staffId: staff.id,
                payment: state.payment,
                subtotal: subtotal,
                discount: discount,
                total: total,
                paidAmount: paid,
                lines: [
                  for (final line in drafts)
                    NewSaleLine(
                      productId: line.productId,
                      nameMm: line.nameMm,
                      qty: line.qty,
                      unitPrice: line.unitPrice,
                      unitCost: line.unitCost,
                      packSize: line.packSize,
                    ),
                ],
              ),
            );
      }
      ref.invalidate(pendingCountProvider);
      ref.invalidate(productListProvider);
      ref.invalidate(profitReportProvider);
      ref.invalidate(saleListProvider);
      state = const SaleUiState();
      return true;
    } catch (error) {
      state = state.copyWith(saving: false, message: 'သိမ်းမရပါ။');
      return false;
    }
  }
}

SaleLineDraft? _draft(CartLine line, SaleProduct? product) {
  if (product == null && line.unitPrice == null) return null;
  final pack = line.packSize ?? (line.asPack && (product?.hasPack ?? false) ? product!.packSize! : 1);
  return SaleLineDraft(
    productId: line.productId,
    nameMm: (product?.nameMm ?? line.nameMm ?? '').trim(),
    qty: line.qty,
    unitPrice: line.unitPrice ?? product!.unitPrice(asPack: line.asPack),
    unitCost: line.unitCost ?? product!.unitCost(asPack: line.asPack),
    packSize: pack,
  );
}

final saleControllerProvider = NotifierProvider<SaleController, SaleUiState>(SaleController.new);
