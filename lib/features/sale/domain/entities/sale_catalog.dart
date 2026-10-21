class SaleCategory {
  const SaleCategory({required this.id, required this.nameMm});

  final String id;
  final String nameMm;
}

class SaleProduct {
  const SaleProduct({
    required this.id,
    required this.categoryId,
    required this.nameMm,
    required this.unitMm,
    required this.price,
    required this.cost,
    this.barcode,
    this.packPrice,
    this.packSize,
    this.previousPrice,
    this.previousPackPrice,
  });

  final String id;
  final String categoryId;
  final String nameMm;
  final String unitMm;
  final double price;
  final double cost;
  final String? barcode;
  final double? packPrice;
  final double? packSize;
  final double? previousPrice;
  final double? previousPackPrice;

  bool get hasPack => packPrice != null && packPrice! > 0 && (packSize ?? 0) > 1;

  double unitPrice({required bool asPack}) => asPack && hasPack ? packPrice! : price;

  double unitCost({required bool asPack}) => asPack && hasPack ? cost * packSize! : cost;

  double stockQty({required bool asPack, required num qty}) => asPack && hasPack ? qty * packSize! : qty.toDouble();

  String soldUnit({required bool asPack}) => asPack && hasPack ? 'ဖာ' : unitMm;
}

class SaleCatalog {
  const SaleCatalog({required this.categories, required this.products});

  final List<SaleCategory> categories;
  final List<SaleProduct> products;
}
