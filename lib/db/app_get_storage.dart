import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  AppGetStorage._internal();
  static final AppGetStorage _instance = AppGetStorage._internal();
  factory AppGetStorage() => _instance;
  static final GetStorage _getStorage = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await _getStorage.write(key, value);
  }

  dynamic read(String key) {
    return _getStorage.read(key);
  }

  Future<void> delete(String key) async {
    await _getStorage.remove(key);
  }

  Future<void> clear() async {
    await _getStorage.erase();
  }
}
