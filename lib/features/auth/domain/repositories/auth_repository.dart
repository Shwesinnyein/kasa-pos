import '../entities/staff_user.dart';

abstract class AuthRepository {
  Future<StaffUser?> findByPin(String pin);
}
