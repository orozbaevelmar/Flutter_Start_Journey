import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UnAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add any common headers for unauthenticated requests
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle any common errors for unauthenticated requests
    handler.next(err);
  }
} 