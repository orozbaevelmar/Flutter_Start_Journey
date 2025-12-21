import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class TokenService {
  static const String _tokenKey = 'auth_token';

  final SharedPreferences _prefs;

  TokenService(this._prefs);

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  Future<void> deleteTokens() async {
    await _prefs.remove(_tokenKey);
  }
}
