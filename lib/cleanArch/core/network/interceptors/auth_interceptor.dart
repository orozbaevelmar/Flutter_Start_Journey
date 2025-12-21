import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:start_journey/cleanArch/core/services/token_service.dart';
import 'package:start_journey/cleanArch/core/utils/jwt_utils.dart';
import 'package:start_journey/cleanArch/features/auth/domain/repositories/auth_repository.dart';

const _tag = " [ AuthInterceptor ] ";

@lazySingleton
class AuthInterceptor extends Interceptor {
  final TokenService _tokenService;
  final AuthRepository _authRepository;
  final bool logHttpRequests = true;
  final bool logHttpErrors = false;
  bool _isRefreshing = false;

  AuthInterceptor(this._tokenService, this._authRepository);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.getToken();
    if (token != null) {
      // Check if token is expired or about to expire (within 2 days)
      if (JwtUtils.getExpiresInSeconds(token) < 172800) {
        // 2 days in seconds
        //await _refreshToken(token);
        final newToken = await _tokenService.getToken();
        if (newToken != null) {
          options.headers.addAll({'Authorization': 'Bearer $newToken'});
        }
      } else {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }
    }
    if (logHttpRequests) {
      debugPrint('>> $_tag ___ ${options.uri.toString()}');
      debugPrint('>> $_tag ___ Bearer $token');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (logHttpRequests) {
        debugPrint(
            '<< $_tag  ${response.statusCode} ${response.requestOptions.uri.toString()}');
      }
      debugPrint('<< $_tag  ${response.data}');

      final data = response.data;

      // Safely check if statusCode exists and is an int
      final statusCode =
          data is Map<String, dynamic> ? data['statusCode'] : null;

      if (statusCode == 401) {
        log("AUTH ERROR 401 detected. Triggering logout...");
        //await handleUnauthorized();

        // Reject so request caller also knows it failed
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Unauthorized (401)',
          ),
        );
      }

      // If no statusCode or it’s not 401 → proceed as normal
      return handler.next(response);
    } catch (e, st) {
      log('AuthInterceptor error: $e\n$st');
      // Never break the app because of interceptor
      return handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (logHttpErrors) {
      debugPrint(
          '<< $_tag  ${err.response?.statusCode} ${err.requestOptions.uri.toString()}');
    }

    if (err.response?.statusCode == 401) {
      // handleUnauthorized();
    }
    handler.next(err);
  }

  // Future<void> _refreshToken(String token) async {
  //   if (_isRefreshing) {
  //     // If already refreshing, wait for the current refresh to complete
  //     await Future.delayed(const Duration(milliseconds: 100));
  //     return;
  //   }

  //   _isRefreshing = true;
  //   try {
  //     final failureOrSuccess = await _authRepository.refreshToken(token);
  //     failureOrSuccess.fold((_) {}, (success) async {
  //       await _tokenService.saveToken(success.token);
  //     });
  //   } finally {
  //     _isRefreshing = false;
  //   }
  // }

  // Future<void> handleUnauthorized() async {
  //   log("AUTH ERROR 401, must log out and navigate to login");
  //   try {
  //     // Sign out the user and navigate to login screen
  //     await _authRepository.signOut();
  //     NavigationHelper.router.pushReplacementNamed(
  //       NavigationHelper.loginRouteName,
  //     );
  //   } catch (e, st) {
  //     log('Failed to handle unauthorized: $e\n$st');
  //   }
  // }
}
