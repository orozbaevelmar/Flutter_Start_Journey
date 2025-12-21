import 'package:flutter_test/flutter_test.dart';
import 'package:start_journey/cleanArch/core/constants/string_constants.dart';
import 'package:start_journey/cleanArch/core/utils/error_utils.dart';

void main() {
  group('ErrorUtils', () {
    test('should handle string response data', () {
      const responseData = '{"message": "Invalid credentials"}';
      final result = ErrorUtils.handleApiError(responseData);
      expect(result, equals('Invalid credentials'));
    });

    test('should handle map response data', () {
      final responseData = {'message': 'Invalid credentials'};
      final result = ErrorUtils.handleApiError(responseData);
      expect(result, equals('Invalid credentials'));
    });

    test('should return unknown error when message is null', () {
      final responseData = {'other_field': 'some value'};
      final result = ErrorUtils.handleApiError(responseData);
      expect(result, equals(StringConstants.unknownErrorTryAgain));
    });

    test('should handle invalid JSON string', () {
      const responseData = 'invalid json';
      final result = ErrorUtils.handleApiError(responseData);
      expect(result, equals(StringConstants.unknownErrorTryAgain));
    });
  });
}
