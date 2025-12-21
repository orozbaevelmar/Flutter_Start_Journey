import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:start_journey/cleanArch/core/network/interceptors/auth_interceptor.dart';

import '../../../mocks.mocks.dart';

void main() {
  late AuthInterceptor authInterceptor;
  late MockTokenService mockTokenService;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockTokenService = MockTokenService();
    mockAuthRepository = MockAuthRepository();

    authInterceptor = AuthInterceptor(mockTokenService, mockAuthRepository);
  });

  group('AuthInterceptor Tests', () {
    test('should add authorization header when token exists', () async {
      // Arrange
      const token = 'test_token';
      when(mockTokenService.getToken()).thenAnswer((_) async => token);

      final handler = RequestInterceptorHandler();
      final options = RequestOptions(path: '/test');

      // Act
      authInterceptor.onRequest(options, handler);

      // Assert
      expect(options.headers['Authorization'], 'Bearer $token');
      verify(mockTokenService.getToken()).called(1);
    });

    test('should not add authorization header when token is null', () async {
      // Arrange
      when(mockTokenService.getToken()).thenAnswer((_) async => null);

      final handler = RequestInterceptorHandler();
      final options = RequestOptions(path: '/test');

      // Act
      authInterceptor.onRequest(options, handler);

      // Assert
      expect(options.headers['Authorization'], isNull);
      verify(mockTokenService.getToken()).called(1);
    });

    test('should handle token refresh on 401 response', () async {
      // Arrange
      const oldToken = 'old_token';

      when(mockTokenService.getToken()).thenAnswer((_) async => oldToken);

      final handler = ErrorInterceptorHandler();
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 401,
      );

      // Act
      authInterceptor.onError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
        ),
        handler,
      );
    });

    test('should not refresh token on non-401 error', () async {
      // Arrange
      const token = 'test_token';

      when(mockTokenService.getToken()).thenAnswer((_) async => token);

      final handler = ErrorInterceptorHandler();
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 400,
      );

      // Act
      authInterceptor.onError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
        ),
        handler,
      );
    });
  });
}
