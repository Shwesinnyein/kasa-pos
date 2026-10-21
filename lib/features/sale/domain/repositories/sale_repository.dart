import '../entities/sale_catalog.dart';
import '../sale_math.dart';

class NewSaleLine {
  const NewSaleLine({
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
}

class NewSale {
  const NewSale({
    required this.staffId,
    required this.payment,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paidAmount,
    required this.lines,
  });

  final String staffId;
  final PaymentMethod payment;
  final double subtotal;
  final double discount;
  final double total;
  final double paidAmount;
  final List<NewSaleLine> lines;
}

abstract class SaleRepository {
  Future<SaleCatalog> loadCatalog();
  Future<String> save(NewSale sale);
}
