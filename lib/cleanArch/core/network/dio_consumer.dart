import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/core/network/api_consumer.dart';
import 'package:start_journey/cleanArch/core/network/interceptors/unauth_interceptor.dart';

const _tag = "[ DioConsumer ]";

class DioConsumer implements ApiConsumer {
  final Dio _dio;
  final Interceptor? interceptor;
  final AppFlavorConfig appConfig;

  DioConsumer({
    required Dio dioClient,
    required this.appConfig,
    this.interceptor,
  }) : _dio = dioClient {
    _configureDio();
  }

  void _configureDio() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.options
      ..baseUrl = appConfig.apiBaseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 20)
      ..sendTimeout = const Duration(seconds: 20)
      ..validateStatus =
          (status) => status != null && status >= 200 && status < 300;

    // Add interceptors
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
        maxWidth: 90,
      ),
    );
    if (interceptor != null) {
      _dio.interceptors.add(interceptor!);
    } else {
      _dio.interceptors.add(getIt<UnAuthInterceptor>());
    }
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool isMultipart = false,
    int? timeOut,
    Options? options,
  }) async {
    try {
      log("$_tag, Request: GET $path");
      log("$_tag, Headers: ${_dio.options.headers}");
      log("$_tag, Base URL: ${_dio.options.baseUrl}");

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
              listFormat: ListFormat.multiCompatible,
            ),
      );

      log("$_tag, Response: ${response.data}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    bool isMultipart = false,
    int? timeOut,
    Options? options,
  }) async {
    if (timeOut != null) {
      _dio.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    _dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
    };
    try {
      final response = await _dio.post(path, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    bool isMultipart = false,
    int? timeOut,
  }) async {
    try {
      final payload = isMultipart && data is Map<String, dynamic>
          ? FormData.fromMap(data)
          : data;

      final Duration? t =
          timeOut == null ? null : Duration(milliseconds: timeOut);

      return await _dio.put(
        path,
        data: payload,
        cancelToken: cancelToken,
        options: Options(
          sendTimeout: t,
          receiveTimeout: t,
          contentType: isMultipart ? 'multipart/form-data' : 'application/json',
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> delete(
    String path, {
    CancelToken? cancelToken,
    int? timeOut,
  }) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  void _handleDioError(DioException error) {
    log("DIO ERROR: ${error.error}");

    if (_isNoConnectionError(error)) {
      throw 'Connection Error – No internet connection';
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw 'Connection timeout';
      case DioExceptionType.sendTimeout:
        throw 'Send timeout';
      case DioExceptionType.receiveTimeout:
        throw 'Receive timeout';
      case DioExceptionType.badCertificate:
        throw 'SSL certificate error';
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            throw 'Bad request';
          case 401:
            throw 'Unauthorized';
          case 403:
            throw 'Forbidden';
          case 404:
            throw 'Not found';
          case 500:
            throw 'Internal server error';
          default:
            final data = error.response?.data;
            if (data is Map &&
                data['message'] is String &&
                (data['message'] as String).isNotEmpty) {
              throw data['message'];
            }
            throw 'Something went wrong';
        }
      case DioExceptionType.cancel:
        throw 'Request cancelled';
      case DioExceptionType.connectionError:
        throw 'Connection Error – No internet connection';
      case DioExceptionType.unknown:
        throw 'Something went wrong';
    }
  }

  bool _isNoConnectionError(DioException e) {
    if (e.type == DioExceptionType.connectionError) return true;
    if (e.error is SocketException) return true;

    final msg = (e.message ?? '').toLowerCase();
    return msg.contains('failed host lookup') ||
        msg.contains('network is unreachable') ||
        msg.contains('no address associated with hostname');
  }
}
