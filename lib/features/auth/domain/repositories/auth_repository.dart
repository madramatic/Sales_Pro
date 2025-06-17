import 'package:sales_pro/core/utils/typedef.dart';
import 'package:sales_pro/shared/domain/entities/all_information.dart';
import 'package:sales_pro/shared/domain/entities/user.dart';

abstract class AuthRepository {
  ResultFuture<User> login({
    required String email,
    required String password,
  });

  ResultVoid logout();

  ResultFuture<bool> isLoggedIn();

  ResultFuture<User?> getCurrentUser();

  ResultFuture<AllInformation> getAllInformation();
}
