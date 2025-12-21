import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/core/network/dio_consumer.dart';
import 'package:start_journey/cleanArch/core/network/interceptors/auth_interceptor.dart';

import '../../mocks.mocks.dart';

@GenerateMocks([])
class MockAuthInterceptor extends Mock implements AuthInterceptor {}

class MockAppConfig extends Mock implements AppFlavorConfig {
  @override
  String get apiBaseUrl => 'https://test.api.com/';

  @override
  bool get isDevelopment => true;
}

class MockInterceptor extends Interceptor {}

void main() {
  late DioConsumer dioConsumer;
  late Dio mockDio;
  late AppFlavorConfig appConfig;
  late MockAuthInterceptor mockAuthInterceptor;
  late Interceptors mockInterceptors;
  late MockAppConfig mockAppConfig;
  late MockInterceptor mockInterceptor;

  setUp(() {
    mockDio = MockDio();
    mockAuthInterceptor = MockAuthInterceptor();
    mockInterceptors = Interceptors();
    mockInterceptors.add(mockAuthInterceptor);
    mockDio.interceptors.add(mockAuthInterceptor);

    appConfig = getIt<AppFlavorConfig>();

    dioConsumer = DioConsumer(
      dioClient: mockDio,
      appConfig: appConfig,
      interceptor: mockAuthInterceptor,
    );

    mockAppConfig = MockAppConfig();
    mockInterceptor = MockInterceptor();

    dioConsumer = DioConsumer(
      dioClient: mockDio,
      appConfig: mockAppConfig,
      interceptor: mockInterceptor,
    );
  });

  group('DioConsumer Tests', () {
    test('initializes with correct configuration', () {
      expect(mockDio.options.baseUrl, equals('https://test.api.com/'));
      expect(mockDio.options.responseType, equals(ResponseType.json));
      expect(mockDio.options.followRedirects, equals(false));
      expect(
        mockDio.options.connectTimeout,
        equals(const Duration(seconds: 3)),
      );
      expect(mockDio.interceptors, contains(mockInterceptor));
    });

    test('should make GET request successfully', () async {
      // Arrange
      const path = '/test';
      final response = Response(
        data: {'data': 'test'},
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      );

      // Act
      final result = await dioConsumer.get(path);

      // Assert
      expect(result.data, equals(response.data));
      expect(result.statusCode, equals(response.statusCode));
    });

    test('should make POST request successfully', () async {
      // Arrange
      const path = '/test';
      final requestData = {'data': 'test'};
      final responseData = {'result': 'success'};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      );

      // Act
      final result = await dioConsumer.post(path, data: requestData);

      // Assert
      expect(result.data, equals(response.data));
      expect(result.statusCode, equals(200));
    });

    test('should make PUT request successfully', () async {
      // Arrange
      const path = '/test';
      final requestData = {'data': 'test'};
      final response = Response(
        data: {'result': 'success'},
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      );

      // Act
      final result = await dioConsumer.put(path, data: requestData);

      // Assert
      expect(result.data, equals(response.data));
      expect(result.statusCode, equals(response.statusCode));
    });

    test('should make DELETE request successfully', () async {
      // Arrange
      const path = '/test';
      final response = Response(
        data: {'result': 'success'},
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      );

      // Act
      final result = await dioConsumer.delete(path);

      // Assert
      expect(result.data, equals(response.data));
      expect(result.statusCode, equals(response.statusCode));
    });

    test('handles connection timeout error correctly', () async {
      // Arrange
      mockDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionTimeout,
              ),
            );
          },
        ),
      );

      // Act & Assert
      expect(() => dioConsumer.get('/test'), throwsA('Connection timeout'));
    });

    test('handles bad response error correctly', () async {
      // Arrange
      mockDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.reject(
              DioException(
                requestOptions: options,
                response: Response(requestOptions: options, statusCode: 400),
                type: DioExceptionType.badResponse,
              ),
            );
          },
        ),
      );

      // Act & Assert
      expect(() => dioConsumer.get('/test'), throwsA('Bad request'));
    });
  });
}
