import '../../../../core/myanmar/myanmar_digits.dart';
import '../sale_math.dart';

class SaleSummary {
  const SaleSummary({required this.id, required this.saleNo, required this.soldAt, required this.total});

  final String id;
  final String saleNo;
  final DateTime soldAt;
  final double total;
}

class SaleLineRecord {
  const SaleLineRecord({
    required this.productId,
    required this.nameMm,
    required this.unitMm,
    required this.qty,
    required this.unitPrice,
    required this.unitCost,
    required this.lineTotal,
    required this.packSize,
  });

  final String productId;
  final String nameMm;
  final String unitMm;
  final double qty;
  final double unitPrice;
  final double unitCost;
  final double lineTotal;
  final double packSize;

  bool get asPack => packSize > 1;
}

class SaleRecord {
  const SaleRecord({
    required this.id,
    required this.saleNo,
    required this.soldAt,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paidAmount,
    required this.payment,
    required this.lines,
  });

  final String id;
  final String saleNo;
  final DateTime soldAt;
  final double subtotal;
  final double discount;
  final double total;
  final double paidAmount;
  final PaymentMethod payment;
  final List<SaleLineRecord> lines;
}

class SaleLineDraft {
  const SaleLineDraft({
    required this.productId,
    required this.nameMm,
    required this.qty,
    required this.unitPrice,
    required this.unitCost,
    this.packSize = 1,
  });

  final String productId;
  final String nameMm;
  final int qty;
  final double unitPrice;
  final double unitCost;
  final double packSize;

  bool get asPack => packSize > 1;
}

class SaleUpdate {
  const SaleUpdate({required this.discount, required this.payment, required this.paidAmount, required this.lines});

  final double discount;
  final PaymentMethod payment;
  final double paidAmount;
  final List<SaleLineDraft> lines;
}

/// S0001 is shown as အရောင်း- ၁.
String saleListLabel(String saleNo) {
  final match = RegExp(r'\d+').firstMatch(saleNo);
  final number = int.tryParse(match?.group(0) ?? '');
  if (number == null || number == 0) return saleNo;
  return 'အရောင်း- ${MyanmarDigits.format(number)}';
}
