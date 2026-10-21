class NamedOption {
  const NamedOption(this.id, this.name);

  final String id;
  final String name;
}

class ProductFormData {
  const ProductFormData({
    required this.categories,
    required this.units,
    this.id,
    this.nameMm = '',
    this.categoryId,
    this.unitId,
    this.barcode = '',
    this.price,
    this.reorderLevel,
    this.cost = 0,
  });

  final List<NamedOption> categories;
  final List<NamedOption> units;
  final String? id;
  final String nameMm;
  final String? categoryId;
  final String? unitId;
  final String barcode;
  final double? price;
  final double? reorderLevel;
  final double cost;

  bool get isNew => id == null;
}

class ProductDraft {
  const ProductDraft({
    required this.nameMm,
    required this.unitName,
    required this.barcode,
    this.id,
    this.categoryId,
    this.unitId,
    this.price,
    this.reorderLevel,
  });

  final String? id;
  final String nameMm;
  final String? categoryId;
  final String? unitId;
  final String unitName;
  final String barcode;
  final double? price;
  final double? reorderLevel;
}
