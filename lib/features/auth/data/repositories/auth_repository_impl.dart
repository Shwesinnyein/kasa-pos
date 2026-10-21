import '../../domain/entities/staff_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthLocalDataSource _dataSource;

  @override
  Future<StaffUser?> findByPin(String pin) => _dataSource.findByPin(pin);
}
