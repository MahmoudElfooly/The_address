import '../baseRepo/bearer_token_repo.dart';

class HeaderData {
  HeaderData._privateConstructor();

  static final HeaderData _instance = HeaderData._privateConstructor();

  factory HeaderData() {
    return _instance;
  }
  static Map<String, String> getHeader() {
    var accessToken = BearerTokenRepo.getBearerToken();
    Map<String, String> graphHeaders = {
      if (accessToken != null) 'Authorization': accessToken,
      'accept': 'application/json',
      'content-type': 'application/json',
      // 'Platform': 'Mobile',
      // 'LanguageCode': "En"
      // Get.locale.toString() == ConstantKeys.arabicLang ? "Ar" : "En"
    };
    return graphHeaders;
  }
}
