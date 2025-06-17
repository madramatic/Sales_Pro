import 'package:equatable/equatable.dart';
import 'package:sales_pro/shared/domain/entities/user.dart';

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
