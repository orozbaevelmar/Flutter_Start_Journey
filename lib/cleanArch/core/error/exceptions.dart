import 'package:equatable/equatable.dart';

class StartJourneyException extends Equatable implements Exception {
  final String? message;

  const StartJourneyException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class ServerException extends StartJourneyException {
  const ServerException([message]) : super(message ?? "tryAgain");
}

class FetchDataException extends StartJourneyException {
  const FetchDataException([message]) : super(message ?? "tryAgain");
}

class NetworkException extends StartJourneyException {
  const NetworkException([message]) : super(message ?? "tryAgain");
}

class BadRequestException extends StartJourneyException {
  const BadRequestException([message]) : super(message ?? "badRequest");
}

class UnauthorizedException extends StartJourneyException {
  const UnauthorizedException([message]) : super(message ?? "unauthorized");
}

class NotFoundException extends StartJourneyException {
  const NotFoundException([message]) : super(message ?? "requestInfoNotFound");
}

class ConflictException extends StartJourneyException {
  const ConflictException([message]) : super(message ?? "conflictError");
}

class InternalServerErrorException extends StartJourneyException {
  const InternalServerErrorException([message])
      : super(message ?? "serverError");
}

class NoInternetConnectionException extends StartJourneyException {
  const NoInternetConnectionException([message])
      : super(message ?? "internetConnectionError");
}

class LaunchUrlException extends StartJourneyException {
  const LaunchUrlException([message]) : super(message ?? "noInternet");
}

class UnknownServerException extends StartJourneyException {
  const UnknownServerException([message])
      : super(message ?? "unknownErrorTryAgain");
}

class CacheException extends Equatable implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class TokenException extends StartJourneyException {
  const TokenException([message]) : super(message ?? "tokenException");
}

class TokenDecodeException implements Exception {
  final String message;

  const TokenDecodeException(this.message);

  @override
  String toString() => 'TokenDecodeException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException({this.message = 'Validation failed', this.errors});

  @override
  String toString() => 'ValidationException: $message';
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
