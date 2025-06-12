import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_pro/features/auth/domain/entities/user.dart';
import 'package:sales_pro/features/auth/domain/usecases/login_usecase.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final User user;
  final String accessToken;

  const LoginSuccess({
    required this.user,
    required this.accessToken,
  });

  @override
  List<Object> get props => [user, accessToken];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}

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
