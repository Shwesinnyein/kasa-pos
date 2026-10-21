import '../../../../core/myanmar/myanmar_digits.dart';

class PurchaseProduct {
  const PurchaseProduct({
    required this.id,
    required this.categoryId,
    required this.nameMm,
    required this.unitMm,
    required this.cost,
    this.barcode,
    this.packSize,
    this.buyPrice,
    this.packBuyPrice,
  });

  final String id;
  final String categoryId;
  final String nameMm;
  final String unitMm;
  final double cost;
  final String? barcode;
  final double? packSize;
  final double? buyPrice;
  final double? packBuyPrice;
}

class PurchaseCategory {
  const PurchaseCategory({required this.id, required this.nameMm});

  final String id;
  final String nameMm;
}

class PurchaseUnit {
  const PurchaseUnit({required this.id, required this.nameMm});

  final String id;
  final String nameMm;
}

class PurchaseCatalog {
  const PurchaseCatalog({required this.categories, required this.products, required this.suppliers, required this.units});

  final List<PurchaseCategory> categories;
  final List<PurchaseProduct> products;
  final List<String> suppliers;
  final List<PurchaseUnit> units;
}

class PurchaseSummary {
  const PurchaseSummary({
    required this.id,
    required this.purchaseNo,
    required this.purchasedAt,
    required this.total,
    required this.pending,
    this.supplierName,
    this.lines = const [],
  });

  final String id;
  final String purchaseNo;
  final DateTime purchasedAt;
  final String? supplierName;
  final double total;
  final bool pending;
  final List<PurchaseLineView> lines;
}

class PurchaseLineView {
  const PurchaseLineView({
    required this.productId,
    required this.nameMm,
    required this.unitMm,
    required this.qty,
    required this.unitCost,
    required this.lineTotal,
    this.packSize = 1,
  });

  final String productId;
  final String nameMm;
  final String unitMm;
  final double qty;
  final double unitCost;
  final double lineTotal;
  final double packSize;
}

class PurchaseDetail {
  const PurchaseDetail({
    required this.id,
    required this.purchaseNo,
    required this.purchasedAt,
    required this.total,
    required this.pending,
    required this.lines,
    this.supplierName,
  });

  final String id;
  final String purchaseNo;
  final DateTime purchasedAt;
  final String? supplierName;
  final double total;
  final bool pending;
  final List<PurchaseLineView> lines;
}

class PurchaseSeed {
  const PurchaseSeed({required this.productId, required this.qty, this.packSize = 1, this.asPack = false});

  final String productId;
  final double qty;
  final double packSize;
  final bool asPack;
}

class NewPurchaseLine {
  const NewPurchaseLine({required this.productId, required this.qty, required this.unitCost, this.packSize = 1});

  final String productId;
  final double qty;
  final double unitCost;
  final double packSize;
}

/// P0001 is shown as အဝယ်စာရင်း- ၁.
String purchaseListLabel(String purchaseNo) {
  final match = RegExp(r'\d+').firstMatch(purchaseNo);
  final number = int.tryParse(match?.group(0) ?? '');
  if (number == null || number == 0) return purchaseNo;
  return 'အဝယ်စာရင်း- ${MyanmarDigits.format(number)}';
}

/// R0001 is shown as ပြန်ဝယ်စာရင်း- ၁.
String repurchaseListLabel(String repurchaseNo) {
  final match = RegExp(r'\d+').firstMatch(repurchaseNo);
  final number = int.tryParse(match?.group(0) ?? '');
  if (number == null || number == 0) return repurchaseNo;
  return 'ပြန်ဝယ်စာရင်း- ${MyanmarDigits.format(number)}';
}

class NewPurchase {
  const NewPurchase({
    required this.staffId,
    required this.purchasedAt,
    required this.lines,
    this.supplierName,
  });

  final String staffId;
  final DateTime purchasedAt;
  final String? supplierName;
  final List<NewPurchaseLine> lines;
}

enum PriceMove { first, up, down, same }

class PurchasePriceChange {
  const PurchasePriceChange({
    required this.purchasedAt,
    required this.purchaseNo,
    required this.paid,
    required this.each,
    required this.packSize,
    required this.move,
  });

  final DateTime purchasedAt;
  final String purchaseNo;
  final double paid;
  final double each;
  final double packSize;
  final PriceMove move;
}
