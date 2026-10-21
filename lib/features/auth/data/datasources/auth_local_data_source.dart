import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/staff_user.dart';
import '../pin_hasher.dart';

class AuthLocalDataSource {
  const AuthLocalDataSource(this._db);

  final AppDatabase _db;

  Future<StaffUser?> findByPin(String pin) async {
    final hash = hashPin(pin);
    final row = await (_db.select(_db.staff)
          ..where((staff) => staff.pinHash.equals(hash) & staff.isActive.equals(true)))
        .getSingleOrNull();
    if (row == null) return null;
    return StaffUser(id: row.id, name: row.name, role: _role(row.role));
  }

  StaffRole _role(String role) => role == 'owner' ? StaffRole.owner : StaffRole.cashier;
}
