import 'package:hive_flutter/hive_flutter.dart';

import 'local_storage_keys.dart';

class LocalStorageManager {
  static final Box _box = Hive.box(DefaultsKeys.hiveBoxKey);

  static Future<void> reOpenBox() async {
    await _box.clear();
    await Hive.openBox(DefaultsKeys.hiveBoxKey);
  }

  static bool isFound(dynamic key) {
    return _box.containsKey(key);
  }

  // Set Data
  static Future<void> setData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // Get Data
  static T? getData<T>(String key) {
    return _box.get(key) as T?;
  }

  // Save Object
  static Future<void> saveObject<T>(dynamic key, T object) async {
    await _box.put(key, object);
  }

  // Get Object
  static T? getObject<T>(dynamic key) {
    return _box.get(key) as T?;
  }

  // Save List of Objects
  static Future<void> saveList<T>(dynamic key, List<T> list) async {
    await _box.put(key, list);
  }

  // Get List of Objects
  static List<T>? getList<T>(String key) {
    return _box.get(key)?.cast<T>();
  }

  // Delete Data
  static Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  // Clear All Data
  static Future<void> clearAll() async {
    await _box.clear();
  }
}
