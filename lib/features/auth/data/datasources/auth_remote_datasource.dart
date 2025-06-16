import 'package:dio/dio.dart';
import 'package:sales_pro/core/constants/api_constants.dart';
import 'package:sales_pro/core/error/exceptions.dart';
import 'package:sales_pro/features/auth/data/models/login_request_model.dart';
import 'package:sales_pro/features/auth/data/models/login_response_model.dart';
import 'package:sales_pro/shared/data/models/all_information_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<AllInformationModel> getAllInformation(String accessToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('Please check your internet connection');
      }

      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.data['message'] ?? 'An error occurred';

        if (statusCode == 401) {
          throw ServerException(
            message: 'Invalid email or password',
            statusCode: 401,
          );
        } else if (statusCode == 422) {
          throw ServerException(
            message: message,
            statusCode: 422,
          );
        } else {
          throw ServerException(
            message: message,
            statusCode: statusCode,
          );
        }
      }

      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<AllInformationModel> getAllInformation(String accessToken) async {
    try {
      final response = await _dio.get(
        ApiConstants.allInformationEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return AllInformationModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch information',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw const NetworkException('Please check your internet connection');
      }

      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.data['message'] ?? 'An error occurred';

        if (statusCode == 401) {
          throw ServerException(
            message: 'Unauthorized access',
            statusCode: 401,
          );
        } else {
          throw ServerException(
            message: message,
            statusCode: statusCode,
          );
        }
      }

      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
