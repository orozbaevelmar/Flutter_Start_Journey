import 'dart:convert';
import 'dart:developer';

import 'package:start_journey/cleanArch/core/constants/string_constants.dart';

const _tag = '[ ErrorUtils ]';

class ErrorUtils {
  static String handleApiError(dynamic responseData) {
    try {
      if (responseData == null) {
        return StringConstants.unknownErrorTryAgain;
      }

      // 📌 Detect Internet / Network errors
      if (_isConnectionError(responseData)) {
        return StringConstants.noInternetConnection;
      }

      // 1. If response is a raw String
      if (responseData is String) {
        try {
          final decoded = jsonDecode(responseData);
          if (decoded is Map<String, dynamic>) {
            return _extractMessageFromMap(decoded);
          } else {
            return responseData;
          }
        } catch (_) {
          return responseData;
        }
      }

      // 2. If server returned Map
      if (responseData is Map<String, dynamic>) {
        return _extractMessageFromMap(responseData);
      }

      // 3. Fallback
      return responseData.toString();
    } catch (e) {
      log('$_tag Unexpected error format: $e');
      return StringConstants.unknownErrorTryAgain;
    }
  }

  /// Checks if error describes network / connectivity error
  static bool _isConnectionError(dynamic error) {
    final message = error.toString().toLowerCase();

    return message.contains('socketexception') ||
        message.contains('failed host lookup') ||
        message.contains('network is unreachable') ||
        message.contains('connection aborted') ||
        message.contains('no address associated with hostname') ||
        message.contains('handshakeexception');
  }

  static String _extractMessageFromMap(Map<String, dynamic> map) {
    final message = map['message'] ??
        map['email'] ??
        map['resetCode'] ??
        map['password'] ??
        map['verificationCode'] ??
        map['phone'];

    if (message is String && message.isNotEmpty) {
      return message;
    }

    return StringConstants.unknownErrorTryAgain;
  }
}
