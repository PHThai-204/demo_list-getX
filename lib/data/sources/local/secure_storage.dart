import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _accessTokenKey = 'access_token_key';

  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
