import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:start_journey/cleanArch/core/utils/validate_image_url.dart';

@GenerateMocks([])
void main() {
  group('ImageUrlValidation', () {
    late MockDio mockDio;
    const testUrl = 'https://api.dev.startJourney.com/images/company_logo';

    setUp(() {
      mockDio = MockDio();
    });

    test('should return true for valid image URL', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: testUrl),
        statusCode: 200,
        headers: Headers.fromMap({
          'content-type': ['image/jpeg'],
        }),
      );

      when(mockDio.head(testUrl)).thenAnswer((_) async => response);

      // Act
      final result = await ImageUrlValidation.isValidateCompanyLogoUrl(
        '123',
        dio: mockDio,
      );

      // Assert
      expect(result, isTrue);
      verify(mockDio.head(testUrl)).called(1);
    });

    test('should return false for non-image content type', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: testUrl),
        statusCode: 200,
        headers: Headers.fromMap({
          'content-type': ['text/html'],
        }),
      );

      when(mockDio.head(testUrl)).thenAnswer((_) async => response);

      // Act
      final result = await ImageUrlValidation.isValidateCompanyLogoUrl(
        '123',
        dio: mockDio,
      );

      // Assert
      expect(result, isFalse);
      verify(mockDio.head(testUrl)).called(1);
    });

    test('should return false for non-200 status code', () async {
      // Arrange
      final response = Response(
        requestOptions: RequestOptions(path: testUrl),
        statusCode: 404,
        headers: Headers.fromMap({
          'content-type': ['image/jpeg'],
        }),
      );

      when(mockDio.head(testUrl)).thenAnswer((_) async => response);

      // Act
      final result = await ImageUrlValidation.isValidateCompanyLogoUrl(
        '123',
        dio: mockDio,
      );

      // Assert
      expect(result, isFalse);
      verify(mockDio.head(testUrl)).called(1);
    });

    test('should return false when Dio throws an error', () async {
      // Arrange
      when(
        mockDio.head(testUrl),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: testUrl)));

      // Act
      final result = await ImageUrlValidation.isValidateCompanyLogoUrl(
        '123',
        dio: mockDio,
      );

      // Assert
      expect(result, isFalse);
      verify(mockDio.head(testUrl)).called(1);
    });
  });
}

class MockDio extends Mock implements Dio {}
