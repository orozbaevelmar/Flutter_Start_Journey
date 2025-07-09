// core/error/exceptions.dart

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ServerException({
    this.message = 'Server error occurred',
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Network connection failed'});

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException({this.message = 'Validation failed', this.errors});

  @override
  String toString() => 'ValidationException: $message';
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({this.message = 'Authentication required'});

  @override
  String toString() => 'UnauthorizedException: $message';
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({this.message = 'Resource not found'});

  @override
  String toString() => 'NotFoundException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({this.message = 'Request timed out'});

  @override
  String toString() => 'TimeoutException: $message';
}
