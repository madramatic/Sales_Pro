import 'package:sales_pro/features/auth/data/models/user_model.dart';

class LoginResponseModel {
  final String accessToken;
  final UserModel user;

  const LoginResponseModel({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'] as String,
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user': user.toJson(),
    };
  }
}
