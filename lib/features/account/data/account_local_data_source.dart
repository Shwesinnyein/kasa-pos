import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_seeder.dart';
import '../../auth/data/pin_hasher.dart';
import '../../auth/domain/entities/staff_user.dart';

class AccountUser {
  const AccountUser({required this.id, required this.name, required this.role, required this.active});

  final String id;
  final String name;
  final StaffRole role;
  final bool active;
}

class AccountLocalDataSource {
  AccountLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<List<AccountUser>> load() async {
    final rows = await (_db.select(_db.staff)..orderBy([(row) => OrderingTerm.asc(row.name)])).get();
    return [
      for (final row in rows)
        AccountUser(id: row.id, name: row.name, role: row.role == 'owner' ? StaffRole.owner : StaffRole.cashier, active: row.isActive),
    ];
  }

  Future<String?> save({String? id, required String name, required StaffRole role, required String pin, required bool active}) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'name';
    final existing = id == null ? null : await (_db.select(_db.staff)..where((row) => row.id.equals(id))).getSingleOrNull();
    if (existing == null && pin.length != 4) return 'pin';
    if (pin.isNotEmpty && pin.length != 4) return 'pin';
    if (pin.isNotEmpty) {
      final hash = hashPin(pin);
      final taken = await (_db.select(_db.staff)..where((row) => row.pinHash.equals(hash))).getSingleOrNull();
      if (taken != null && taken.id != id) return 'pin_used';
    }
    if (existing != null && existing.role == 'owner' && existing.isActive && (role != StaffRole.owner || !active)) {
      if (await _otherActiveOwners(existing.id) == 0) return 'owner';
    }
    final nowRole = role == StaffRole.owner ? 'owner' : 'cashier';
    if (existing == null) {
      await _db.into(_db.staff).insert(
            StaffCompanion.insert(
              id: _uuid.v4(),
              shopId: DatabaseSeeder.shopId,
              name: trimmed,
              role: nowRole,
              pinHash: hashPin(pin),
              isActive: Value(active),
            ),
          );
      return null;
    }
    await (_db.update(_db.staff)..where((row) => row.id.equals(existing.id))).write(
      StaffCompanion(
        name: Value(trimmed),
        role: Value(nowRole),
        isActive: Value(active),
        pinHash: pin.isEmpty ? const Value.absent() : Value(hashPin(pin)),
      ),
    );
    return null;
  }

  Future<String?> remove(String id) async {
    final existing = await (_db.select(_db.staff)..where((row) => row.id.equals(id))).getSingleOrNull();
    if (existing == null) return null;
    if (existing.role == 'owner' && existing.isActive && await _otherActiveOwners(id) == 0) return 'owner';
    await (_db.delete(_db.staff)..where((row) => row.id.equals(id))).go();
    return null;
  }

  Future<int> _otherActiveOwners(String id) async {
    final rows = await (_db.select(_db.staff)..where((row) => row.role.equals('owner') & row.isActive.equals(true) & row.id.equals(id).not())).get();
    return rows.length;
  }
}
