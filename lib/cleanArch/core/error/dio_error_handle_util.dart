import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';

Failure handleDioError(DioException error) {
  final status = error.response?.statusCode ?? 0;
  final message = error.response?.data?['message']?.toString() ??
      error.message ??
      'Unexpected network error';

  // 1️⃣ Handle no internet / timeout
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout ||
      error.type == DioExceptionType.connectionError) {
    return const NetworkFailure(message: 'No internet connection!');
  }

  // 2️⃣ Handle specific HTTP status codes
  switch (status) {
    case 400:
      log('DIO 400 ERROR');
      return ServerFailure(message: message, code: status);
    case 401:
      return ServerFailure(message: message, code: status);
    case 403:
      return ServerFailure(message: message, code: status);
    case 404:
      return ServerFailure(message: message, code: status);
    case 500:
      return ServerFailure(message: message, code: status);
    default:
      // Handle all other response codes (e.g., 422, 409, etc.)
      if (status >= 400 && status < 500) {
        return ServerFailure(message: message, code: status);
      } else if (status >= 500) {
        return ServerFailure(message: message, code: status);
      } else {
        return UnknownFailure(message: message, code: status);
      }
  }
}
