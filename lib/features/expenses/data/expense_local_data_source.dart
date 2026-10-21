import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';

class ExpenseCategoryOption {
  const ExpenseCategoryOption({required this.id, required this.name});

  final String id;
  final String name;
}

class ExpenseItem {
  const ExpenseItem({
    required this.id,
    required this.categoryName,
    required this.title,
    required this.amount,
    required this.spentAt,
    required this.pending,
    this.note,
  });

  final String id;
  final String categoryName;
  final String title;
  final double amount;
  final DateTime spentAt;
  final bool pending;
  final String? note;
}

class ExpenseLocalDataSource {
  ExpenseLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<({String? id, String? error})> addCategory(String name) async {
    final typed = name.trim();
    if (typed.isEmpty) return (id: null, error: 'အမျိုးအစားရိုက်ပါ။');
    final rows = await _db.select(_db.expenseCategories).get();
    for (final row in rows) {
      if ((row.nameMm ?? '').trim() == typed) return (id: row.id, error: null);
    }
    final id = _uuid.v4();
    await _db.into(_db.expenseCategories).insert(
      ExpenseCategoriesCompanion.insert(
        id: id,
        shopId: DatabaseSeeder.shopId,
        nameMm: Value(typed),
        syncStatus: const Value('pending'),
        updatedAt: DateTime.now(),
      ),
    );
    return (id: id, error: null);
  }

  Future<List<ExpenseCategoryOption>> loadCategories() async {
    final rows = await _db.select(_db.expenseCategories).get();
    final items = [for (final row in rows) ExpenseCategoryOption(id: row.id, name: row.nameMm ?? row.nameEn ?? '')];
    items.sort((a, b) => a.name.compareTo(b.name));
    return items;
  }

  Future<List<ExpenseItem>> loadList() async {
    final expenses = await _db.select(_db.expenses).get();
    final categories = await _db.select(_db.expenseCategories).get();
    final names = {for (final category in categories) category.id: category.nameMm ?? category.nameEn ?? ''};
    final items = [
      for (final expense in expenses)
        ExpenseItem(
          id: expense.id,
          categoryName: names[expense.expenseCategoryId] ?? '',
          title: expense.title,
          amount: expense.amount,
          spentAt: expense.spentAt,
          pending: expense.syncStatus == 'pending',
          note: expense.note,
        ),
    ];
    items.sort((a, b) => b.spentAt.compareTo(a.spentAt));
    return items;
  }

  Future<String?> save({
    required String staffId,
    required String categoryId,
    required String title,
    required double amount,
    required DateTime spentAt,
    String? note,
  }) async {
    final name = title.trim();
    if (name.isEmpty) return 'အမည်ဖြည့်ပါ။';
    if (categoryId.isEmpty) return 'အမျိုးအစားရွေးပါ။';
    if (amount <= 0) return 'ငွေပမာဏဖြည့်ပါ။';
    final now = DateTime.now();
    await _db.into(_db.expenses).insert(
      ExpensesCompanion.insert(
        id: _uuid.v4(),
        shopId: DatabaseSeeder.shopId,
        deviceId: DatabaseSeeder.deviceId,
        staffId: staffId,
        expenseCategoryId: categoryId,
        title: name,
        amount: amount,
        spentAt: spentAt,
        note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
        syncStatus: const Value('pending'),
        createdAt: now,
        updatedAt: now,
      ),
    );
    return null;
  }
}
