import 'package:flutter_test/flutter_test.dart';
import 'package:kasa_pos/features/purchases/domain/purchase_math.dart';

void main() {
  test('a delivery sets a weighted average cost', () {
    expect(
      weightedAverageCost(onHand: 0, currentCost: 0, receivedQty: 10, receivedCost: 400),
      400,
    );
    expect(
      weightedAverageCost(onHand: 8, currentCost: 400, receivedQty: 10, receivedCost: 500),
      (8 * 400 + 10 * 500) / 18,
    );
    expect(
      weightedAverageCost(onHand: -3, currentCost: 400, receivedQty: 5, receivedCost: 600),
      600,
    );
    expect(baseQty(qty: 2, packSize: 12), 24);
    expect(baseUnitCost(unitCost: 6000, packSize: 12), 500);
  });
}
