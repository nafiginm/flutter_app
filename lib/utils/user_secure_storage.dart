import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyLogin = 'login';
  static const _keyPassword = 'password';

  static Future setLogin(String login) async =>
      await _storage.write(key: _keyLogin, value: login);

  static Future<String?> getlogin() async =>
      await _storage.read(key: _keyLogin);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
