import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredLocalStorage {
  SecuredLocalStorage._internal();

  static final SecuredLocalStorage _singleton = SecuredLocalStorage._internal();

  factory SecuredLocalStorage() {
    return _singleton;
  }

  final _storage = const FlutterSecureStorage();

  Future<bool> setValue(String key, String value) async {
    await _storage.write(key: key, value: value);
    return true;
  }

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  Future<bool> clearValue(String key) async {
    await _storage.delete(key: key);
    return true;
  }

  Future<bool> clearAll() async {
    await _storage.deleteAll();
    return true;
  }
}
