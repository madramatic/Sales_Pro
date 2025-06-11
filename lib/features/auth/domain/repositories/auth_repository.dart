import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  ResultFuture<User> login({
    required String email,
    required String password,
  });

  ResultVoid logout();

  ResultFuture<bool> isLoggedIn();

  ResultFuture<User?> getCurrentUser();
}
