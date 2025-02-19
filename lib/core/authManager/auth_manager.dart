import '../baseRepo/bearer_token_repo.dart';

class AuthManager {
  AuthManager._privateConstructor();

  static final AuthManager _instance = AuthManager._privateConstructor();

  factory AuthManager() {
    return _instance;
  }

  static Future<void> init() async {}

  static Future<void> getWhenLogged() async {}

  static bool isLogged() {
    return BearerTokenRepo.getBearerToken() != null;
  }

  static Future<void> logout() async {
    // showLoading();
    // await Hive.box("user").clear();
    // call api
    // hideLoading();
    // NavigationHelper.pushUntil(
    //     navigatorKey.currentContext!, const LoginInPageView());
  }

  static Future<void> deleteAccount() async {}
}
