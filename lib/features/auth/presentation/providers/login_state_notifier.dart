import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/features/auth/domain/usecases/login_usecase.dart';
import 'package:sales_pro/features/auth/presentation/providers/login_state.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginStateNotifier(this._loginUseCase) : super(const LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const LoginLoading();

    final params = LoginParams(
      email: email.trim(),
      password: password,
    );

    final result = await _loginUseCase(params);

    result.fold(
      (failure) => state = LoginFailure(failure.message),
      (user) {
        // For now, we'll pass an empty string
        state = LoginSuccess(
          user: user,
          accessToken: '', // This should come from the API response
        );
      },
    );
  }

  void resetState() {
    state = const LoginInitial();
  }
}
