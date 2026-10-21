class ProductListItem {
  const ProductListItem({
    required this.id,
    required this.nameMm,
    required this.categoryId,
    required this.categoryName,
    required this.unitMm,
    required this.price,
    required this.cost,
    required this.stock,
    this.soldQty = 0,
    this.soldAmount = 0,
    this.packPrice,
    this.packSize,
    this.buyPrice,
    this.packBuyPrice,
    this.previousPrice,
    this.previousPackPrice,
    this.reorderLevel,
  });

  final String id;
  final String nameMm;
  final String categoryId;
  final String categoryName;
  final String unitMm;
  final double price;
  final double cost;
  final double? packPrice;
  final double? packSize;
  final double? buyPrice;
  final double? packBuyPrice;
  final double? previousPrice;
  final double? previousPackPrice;
  final double stock;
  final double soldQty;
  final double soldAmount;
  final double? reorderLevel;

  bool get isLowStock => reorderLevel != null && stock <= reorderLevel!;
}
