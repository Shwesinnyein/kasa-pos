import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../domain/entities/category_item.dart';

class CategoryLocalDataSource {
  const CategoryLocalDataSource(this._db);

  final AppDatabase _db;

  Future<List<CategoryItem>> load() async {
    final rows = await (_db.select(_db.categories)..where((row) => row.isActive.equals(true))..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).get();
    final items = [
      for (final row in rows)
        CategoryItem(id: row.id, nameMm: row.nameMm ?? row.nameEn ?? '', sortOrder: row.sortOrder),
    ];
    items.sort((a, b) {
      final order = a.sortOrder.compareTo(b.sortOrder);
      return order != 0 ? order : a.nameMm.compareTo(b.nameMm);
    });
    return items;
  }

  Future<String?> add(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'အမည်ဖြည့်ပါ။';
    if (await _nameTaken(trimmed)) return 'ဤအမျိုးအစား ရှိပြီးသားဖြစ်သည်။';

    final rows = await _db.select(_db.categories).get();
    final nextOrder = rows.fold<int>(0, (max, row) => row.sortOrder > max ? row.sortOrder : max) + 1;
    await _db.into(_db.categories).insert(
      CategoriesCompanion.insert(
        id: _uuid.v4(),
        shopId: DatabaseSeeder.shopId,
        nameMm: Value(trimmed),
        sortOrder: Value(nextOrder),
        deviceId: const Value(DatabaseSeeder.deviceId),
        syncStatus: const Value('pending'),
        updatedAt: DateTime.now(),
      ),
    );
    return null;
  }

  Future<String?> rename(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'အမည်ဖြည့်ပါ။';
    if (await _nameTaken(trimmed, exceptId: id)) return 'ဤအမျိုးအစား ရှိပြီးသားဖြစ်သည်။';
    await (_db.update(_db.categories)..where((row) => row.id.equals(id))).write(
      CategoriesCompanion(
        nameMm: Value(trimmed),
        deviceId: const Value(DatabaseSeeder.deviceId),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return null;
  }

  Future<void> hide(String id) async {
    await (_db.update(_db.categories)..where((row) => row.id.equals(id))).write(
      CategoriesCompanion(
        isActive: const Value(false),
        deviceId: const Value(DatabaseSeeder.deviceId),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> _nameTaken(String name, {String? exceptId}) async {
    final rows = await (_db.select(_db.categories)..where((row) => row.isActive.equals(true))).get();
    return rows.any((row) => row.id != exceptId && (row.nameMm ?? '').trim() == name);
  }
}

const _uuid = Uuid();
