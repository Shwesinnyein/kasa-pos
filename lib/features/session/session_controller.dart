import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/domain/entities/staff_user.dart';

class SessionController extends Notifier<StaffUser?> {
  @override
  StaffUser? build() => null;

  void signIn(StaffUser staff) => state = staff;

  void signOut() => state = null;
}

final sessionProvider = NotifierProvider<SessionController, StaffUser?>(SessionController.new);
