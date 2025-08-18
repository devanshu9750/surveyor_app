import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  AppGetStorage._internal();
  static final AppGetStorage _instance = AppGetStorage._internal();
  factory AppGetStorage() => _instance;
  static final GetStorage storage = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await storage.write(key, value);
  }

  dynamic read(String key) {
    return storage.read(key);
  }
}
