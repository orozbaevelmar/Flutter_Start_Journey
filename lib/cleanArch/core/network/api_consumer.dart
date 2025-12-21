import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
    Options? options,
  });

  Future<Response> post(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
    Options? options,
  });

  Future<Response> put(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<Response> delete(
    String path, {
    CancelToken? cancelToken,
    int? timeOut,
  });
}
