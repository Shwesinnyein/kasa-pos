import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../entities/staff_user.dart';
import '../repositories/auth_repository.dart';

class SignInWithPin {
  const SignInWithPin(this._repository);

  final AuthRepository _repository;

  Future<Result<StaffUser>> call(String pin) async {
    if (pin.length != 4) {
      return const Err(Failure('PIN နံပါတ် မှားယွင်းပါသည်။'));
    }
    final staff = await _repository.findByPin(pin);
    if (staff == null) {
      return const Err(Failure('PIN နံပါတ် မှားယွင်းပါသည်။'));
    }
    return Success(staff);
  }
}
