import 'dart:convert';
import 'package:start_journey/cleanArch/core/error/exceptions.dart';

class JwtUtils {
  static Map<String, dynamic> decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw const TokenDecodeException('Invalid token format');
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded) as Map<String, dynamic>;

      if (payloadMap.isEmpty) {
        throw const TokenDecodeException('Empty token payload');
      }

      final expirationTime = payloadMap['exp'] as int?;
      if (expirationTime == null) {
        throw const TokenDecodeException('No expiration time in token');
      }

      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final expired = expirationTime < currentTime;
      final expiresInSec = expirationTime - currentTime;

      return {
        'expired': expired,
        'data': payloadMap,
        'expiresInSec': expiresInSec,
        'expirationTime': expirationTime * 1000, // Convert to milliseconds
      };
    } catch (e) {
      throw TokenDecodeException('Failed to decode token: ${e.toString()}');
    }
  }

  static bool isTokenExpired(String token) {
    try {
      final decoded = decodeToken(token);
      return decoded['expired'] as bool;
    } catch (e) {
      return true;
    }
  }

  static int getExpiresInSeconds(String token) {
    try {
      final decoded = decodeToken(token);
      return decoded['expiresInSec'] as int;
    } catch (e) {
      return 0;
    }
  }
}
