import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../core/result/result.dart';
import '../../session/session_controller.dart';

class SignInState {
  const SignInState({this.pin = '', this.error, this.submitting = false});

  final String pin;
  final String? error;
  final bool submitting;

  SignInState copyWith({String? pin, String? error, bool clearError = false, bool? submitting}) {
    return SignInState(
      pin: pin ?? this.pin,
      error: clearError ? null : error ?? this.error,
      submitting: submitting ?? this.submitting,
    );
  }
}

class SignInController extends Notifier<SignInState> {
  @override
  SignInState build() => const SignInState();

  void pushDigit(String digit) {
    final current = state;
    if (current.submitting || current.pin.length >= 4) return;
    final next = current.pin + digit;
    state = SignInState(pin: next);
    if (next.length == 4) {
      submit();
    }
  }

  void backspace() {
    final current = state;
    if (current.submitting || current.pin.isEmpty) return;
    state = SignInState(pin: current.pin.substring(0, current.pin.length - 1));
  }

  Future<void> submit() async {
    final pin = state.pin;
    if (pin.length != 4 || state.submitting) return;
    state = state.copyWith(submitting: true, clearError: true);
    final result = await ref.read(signInWithPinProvider).call(pin);
    switch (result) {
      case Success(:final value):
        ref.read(sessionProvider.notifier).signIn(value);
        state = const SignInState();
      case Err(:final failure):
        state = SignInState(error: failure.message);
    }
  }
}

final signInControllerProvider = NotifierProvider<SignInController, SignInState>(SignInController.new);
