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

class TokensException implements Exception {
  final String message;

  TokensException({this.message = 'Tokens exception'});

  @override
  String toString() => 'TimeoutException: $message';
}

class OfflineException implements Exception {
  final String message;

  OfflineException({this.message = 'Offline exception'});

  @override
  String toString() => 'TimeoutException: $message';
}

class WeekPassException implements Exception {
  final String message;

  WeekPassException({this.message = 'Week pass exception'});

  @override
  String toString() => 'WeekPassException: $message';
}

class ExistedAccountException implements Exception {
  final String message;

  ExistedAccountException({this.message = 'Existed account exception'});

  @override
  String toString() => 'ExistedAccountException: $message';
}

class NoUserException implements Exception {
  final String message;

  NoUserException({this.message = 'No user exception'});

  @override
  String toString() => 'NoUserException: $message';
}

class WrongPasswordException implements Exception {
  final String message;

  WrongPasswordException({this.message = 'Wrong password'});

  @override
  String toString() => 'WrongPasswordException: $message';
}

class TooManyRequestsException implements Exception {
  final String message;

  TooManyRequestsException({this.message = 'Too amny request'});

  @override
  String toString() => 'TooManyRequestsException: $message';
}
