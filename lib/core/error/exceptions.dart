class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    required this.message,
    this.statusCode,
  });
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}
