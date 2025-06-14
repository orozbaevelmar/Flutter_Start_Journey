import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocaleSecureStorage {
  late final FlutterSecureStorage _storage;
  // use  String? token = await SecureStorage().readSecureData("login_token");
  void init() {
    _storage = const FlutterSecureStorage();
  }

  //final key = (await secureStore.readAll())["some_key"];
  Future<String> getSecureToken() async {
    String abc = (await _storage.readAll())['token'] ?? '';
    return abc;
  }

  saveSecureToken(String value) async {
    await _storage.write(
      key: 'token',
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  deleteSecureData(String key) async {
    await _storage.delete(key: 'token');
  }

/*   Future<void> _readAll() async {
    final all = await _storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    setState(() {
      _items = all.entries
          .map((entry) => _SecItem(entry.key, entry.value))
          .toList(growable: false);
    });
  } */

/*   Future<void> _deleteAll() async {
    await _storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    _readAll();
  } */

  /* IOSOptions _getIOSOptions() => IOSOptions(
        accountName: _getAccountName(),
      ); */

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );
}
