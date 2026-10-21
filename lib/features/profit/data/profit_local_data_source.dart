import '../../../core/database/app_database.dart';

class ProfitSale {
  const ProfitSale({
    required this.saleNo,
    required this.soldAt,
    required this.revenue,
    required this.cost,
  });

  final String saleNo;
  final DateTime soldAt;
  final double revenue;
  final double cost;

  double get profit => revenue - cost;
}

class ProfitDay {
  const ProfitDay({required this.day, required this.sales, required this.cost, required this.expenses});

  final DateTime day;
  final double sales;
  final double cost;
  final double expenses;

  double get net => sales - cost - expenses;
}

class ProfitReport {
  const ProfitReport({
    required this.todaySales,
    required this.todayCost,
    required this.todayExpenses,
    required this.allSales,
    required this.allCost,
    required this.allExpenses,
    required this.sales,
    required this.days,
  });

  final double todaySales;
  final double todayCost;
  final double todayExpenses;
  final double allSales;
  final double allCost;
  final double allExpenses;
  final List<ProfitSale> sales;
  final List<ProfitDay> days;

  double get todayGross => todaySales - todayCost;
  double get todayNet => todayGross - todayExpenses;
  double get allGross => allSales - allCost;
  double get allNet => allGross - allExpenses;
}

class ProfitLocalDataSource {
  const ProfitLocalDataSource(this._db);

  final AppDatabase _db;

  Future<ProfitReport> load() async {
    final sales = await _db.select(_db.sales).get();
    final lines = await _db.select(_db.saleLines).get();
    final expenses = await _db.select(_db.expenses).get();
    final costBySale = <String, double>{};
    for (final line in lines) {
      costBySale[line.saleId] = (costBySale[line.saleId] ?? 0) + line.lineCost;
    }
    final now = DateTime.now();
    bool sameDay(DateTime value) => value.year == now.year && value.month == now.month && value.day == now.day;

    var todaySales = 0.0;
    var todayCost = 0.0;
    var allSales = 0.0;
    var allCost = 0.0;
    final rows = <ProfitSale>[];
    for (final sale in sales) {
      final cost = costBySale[sale.id] ?? 0;
      allSales += sale.total;
      allCost += cost;
      if (sameDay(sale.soldAt)) {
        todaySales += sale.total;
        todayCost += cost;
      }
      rows.add(ProfitSale(saleNo: sale.saleNo, soldAt: sale.soldAt, revenue: sale.total, cost: cost));
    }
    rows.sort((a, b) => b.soldAt.compareTo(a.soldAt));

    final days = <String, ({DateTime day, double sales, double cost, double expenses})>{};
    ({DateTime day, double sales, double cost, double expenses}) bucket(DateTime value) {
      final day = DateTime(value.year, value.month, value.day);
      final key = '${day.year}-${day.month}-${day.day}';
      return days.putIfAbsent(key, () => (day: day, sales: 0, cost: 0, expenses: 0));
    }

    for (final sale in rows) {
      final current = bucket(sale.soldAt);
      final key = '${current.day.year}-${current.day.month}-${current.day.day}';
      days[key] = (day: current.day, sales: current.sales + sale.revenue, cost: current.cost + sale.cost, expenses: current.expenses);
    }
    for (final expense in expenses) {
      final current = bucket(expense.spentAt);
      final key = '${current.day.year}-${current.day.month}-${current.day.day}';
      days[key] = (day: current.day, sales: current.sales, cost: current.cost, expenses: current.expenses + expense.amount);
    }
    final dayRows = [for (final day in days.values) ProfitDay(day: day.day, sales: day.sales, cost: day.cost, expenses: day.expenses)]
      ..sort((a, b) => b.day.compareTo(a.day));

    var todayExpenses = 0.0;
    var allExpenses = 0.0;
    for (final expense in expenses) {
      allExpenses += expense.amount;
      if (sameDay(expense.spentAt)) todayExpenses += expense.amount;
    }

    return ProfitReport(
      todaySales: todaySales,
      todayCost: todayCost,
      todayExpenses: todayExpenses,
      allSales: allSales,
      allCost: allCost,
      allExpenses: allExpenses,
      sales: rows,
      days: dayRows,
    );
  }
}
