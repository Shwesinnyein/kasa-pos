/// New average cost after a delivery.
/// Stock already on hand keeps its old cost. The received quantity uses the price paid.
/// Stock at or below zero does not dilute the new cost.
double weightedAverageCost({
  required double onHand,
  required double currentCost,
  required double receivedQty,
  required double receivedCost,
}) {
  if (receivedQty <= 0) return currentCost;
  final held = onHand > 0 ? onHand : 0.0;
  if (held == 0) return receivedCost;
  return (held * currentCost + receivedQty * receivedCost) / (held + receivedQty);
}

/// A ဖာ contains [packSize] single units. A single purchase uses 1.
double baseQty({required double qty, required double packSize}) => qty * packSize;

double baseUnitCost({required double unitCost, required double packSize}) {
  if (packSize <= 0) return unitCost;
  return unitCost / packSize;
}
