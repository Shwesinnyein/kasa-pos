enum PaymentMethod { cash, card, transfer }

enum DiscountMode { amount, percent }

class CartLine {
  const CartLine({
    required this.productId,
    required this.qty,
    this.asPack = false,
    this.unitPrice,
    this.unitCost,
    this.packSize,
    this.nameMm,
    this.unitMm,
  });

  final String productId;
  final int qty;
  final bool asPack;
  final double? unitPrice;
  final double? unitCost;
  final double? packSize;
  final String? nameMm;
  final String? unitMm;

  CartLine copyWith({int? qty, bool? asPack, bool clearPrice = false}) {
    return CartLine(
      productId: productId,
      qty: qty ?? this.qty,
      asPack: asPack ?? this.asPack,
      unitPrice: clearPrice ? null : unitPrice,
      unitCost: clearPrice ? null : unitCost,
      packSize: clearPrice ? null : packSize,
      nameMm: nameMm,
      unitMm: unitMm,
    );
  }
}

class SaleMath {
  static double subtotal(Iterable<({double price, int qty})> lines) {
    return lines.fold(0, (sum, line) => sum + line.price * line.qty);
  }

  static double discount({required double subtotal, required double input, required DiscountMode mode}) {
    if (input <= 0 || subtotal <= 0) return 0;
    final raw = mode == DiscountMode.percent ? subtotal * input / 100 : input;
    return raw > subtotal ? subtotal : raw;
  }

  static double total({required double subtotal, required double discount}) {
    final value = subtotal - discount;
    return value < 0 ? 0 : value;
  }

  static double change({required double total, required double paid, required PaymentMethod payment}) {
    if (payment != PaymentMethod.cash) return 0;
    final value = paid - total;
    return value < 0 ? 0 : value;
  }
}
