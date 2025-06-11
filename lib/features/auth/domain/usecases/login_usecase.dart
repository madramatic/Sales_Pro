import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sales_pro/core/error/failures.dart';
import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/features/auth/domain/entities/user.dart';
import 'package:sales_pro/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  ResultFuture<User> call(LoginParams params) async {
    // Add validation logic here if needed
    if (params.email.isEmpty) {
      return const Left(ValidationFailure('Email cannot be empty'));
    }

    if (params.password.isEmpty) {
      return const Left(ValidationFailure('Password cannot be empty'));
    }

    if (!_isValidEmail(params.email)) {
      return const Left(ValidationFailure('Please enter a valid email'));
    }

    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
