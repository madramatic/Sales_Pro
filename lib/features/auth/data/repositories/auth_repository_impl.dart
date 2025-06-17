import 'package:dartz/dartz.dart';
import 'package:sales_pro/core/error/exceptions.dart';
import 'package:sales_pro/core/error/failures.dart';
import 'package:sales_pro/core/services/all_infromation_storage_service.dart';
import 'package:sales_pro/core/services/secure_storage_service.dart';
import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sales_pro/features/auth/data/models/login_request_model.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';
import 'package:sales_pro/shared/domain/entities/user.dart';
import 'package:sales_pro/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorageService;
  final AllInformationStorageService _allInformationStorageService;

  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._secureStorageService,
    this._allInformationStorageService,
  );

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

      await _secureStorageService.saveAccessToken(response.accessToken);

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
  ResultFuture<AllInformation> getAllInformation() async {
    try {
      final isCacheValid = await _allInformationStorageService.isCacheValid();
      if (isCacheValid) {
        final cachedData =
            await _allInformationStorageService.getAllInformation();
        if (cachedData != null) {
          return Right(cachedData);
        }
      }

      final accessToken = await _secureStorageService.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        return const Left(ValidationFailure('Access token not found'));
      }

      final response = await _remoteDataSource.getAllInformation(accessToken);
      await _allInformationStorageService.saveAllInformation(response);

      return Right(response);
    } on ServerException catch (e) {
      final cachedData =
          await _allInformationStorageService.getAllInformation();
      if (cachedData != null) {
        return Right(cachedData);
      }
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      final cachedData =
          await _allInformationStorageService.getAllInformation();
      if (cachedData != null) {
        return Right(cachedData);
      }
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      await _secureStorageService.deleteAccessToken();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    try {
      final token = await _secureStorageService.getAccessToken();
      return Right(token != null && token.isNotEmpty);
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
