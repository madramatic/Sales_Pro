class ApiConstants {
  /// Base Url
  static const String baseUrl = 'https://dev.sparkemp.io';

  /// Endpoints
  static const String loginEndpoint = '/api/auth/login';
  static const String allInformationEndpoint = 'api/all-information';

  /// Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
