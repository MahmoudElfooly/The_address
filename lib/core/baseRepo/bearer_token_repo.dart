import '../localStorageManager/local_storage_keys.dart';
import '../localStorageManager/local_storage_manager.dart';

class BearerTokenRepo {
  BearerTokenRepo._privateConstructor();

  static final BearerTokenRepo _instance =
      BearerTokenRepo._privateConstructor();

  factory BearerTokenRepo() {
    return _instance;
  }
  static String? getBearerToken() {
    return LocalStorageManager.getData(DefaultsKeys.bearerToken);
  }

  static Future<void> setBearerToken(String token) async {
    LocalStorageManager.setData(DefaultsKeys.bearerToken, token);
  }

  static Future<void> deleteBearerToken() async {
    LocalStorageManager.deleteData(DefaultsKeys.bearerToken);
  }
}
