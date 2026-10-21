import 'package:flutter_test/flutter_test.dart';
import 'package:kasa_pos/features/sale/domain/sale_math.dart';

void main() {
  test('a pack price uses quantity, and discount and change follow the cart', () {
    final subtotal = SaleMath.subtotal([(price: 2500, qty: 2), (price: 800, qty: 1)]);
    expect(subtotal, 5800);

    final discount = SaleMath.discount(subtotal: 8800, input: 0, mode: DiscountMode.amount);
    final total = SaleMath.total(subtotal: 8800, discount: discount);
    expect(total, 8800);
    expect(SaleMath.change(total: total, paid: 10000, payment: PaymentMethod.cash), 1200);
    expect(SaleMath.change(total: total, paid: 10000, payment: PaymentMethod.card), 0);
  });
}
