import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyUsername = 'StudiosUserName';
  static const _keyUserPassword = 'StudiosUserPassword';
  static const _keyUserAutoLogin = 'StudiosAutoLogin';

  static Future setUsername(String username) async => await _storage.write(key: _keyUsername, value: username);

  static Future<String?> getUsername() async => await _storage.read(key: _keyUsername);

  static Future deleteUsername() async => await _storage.delete(key: _keyUsername);

  static Future setUserPassword(String password) async => await _storage.write(key: _keyUserPassword, value: password);

  static Future<String?> getUserPassword() async => await _storage.read(key: _keyUserPassword);

  static Future deleteUserPassword() async => await _storage.delete(key: _keyUserPassword);

  static Future setAutoLogin(String autoLogin) async => await _storage.write(key: _keyUserAutoLogin, value: autoLogin);

  static Future<String?> getAutoLogin() async => await _storage.read(key: _keyUserAutoLogin);

  static Future deleteAutoLogin() async => await _storage.delete(key: _keyUserAutoLogin);
}
