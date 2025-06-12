import 'package:dartz/dartz.dart';
import 'package:sales_pro/core/error/exceptions.dart';
import 'package:sales_pro/core/error/failures.dart';
import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sales_pro/features/auth/data/models/login_request_model.dart';
import 'package:sales_pro/features/auth/domain/entities/user.dart';
import 'package:sales_pro/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await _remoteDataSource.login(request);
      return Right(response.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      // Implement logout logic here (clear tokens, etc.)
      // For now, we'll just return success
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    try {
      // Implement check if user is logged in
      // Check for stored token, validate it, etc.
      return const Right(false);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<User?> getCurrentUser() async {
    try {
      // Implement get current user logic
      // Return stored user data
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
