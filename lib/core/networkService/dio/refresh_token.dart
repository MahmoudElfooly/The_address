// import 'package:budget/utils/urls.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../../../baseModels/api_request_failure.dart';
// import '../../../../baseModels/refresh_token.dart';
// import '../../../../core/functions/encryption.dart';
// import '../../../../core/functions/log_out.dart';
// import '../../../../utils/constant_keywords.dart';
// import 'abstract_network_service.dart';
// import 'network_exceptions.dart';

// class RefreshToken {
//   static final _storage = GetStorage();

//   static final _networkService = Get.find<AbstractNetworkService>();
//   static Future<Either<ApiRequestFailure, RefreshTokenResponseModel>>
//       refreshTokenApi() async {
//     try {
//       final refreshToken = await _storage.read(ConstantKeys.refreshToken);
//       String accessToken = await _storage.read(ConstantKeys.token);
//       final response = await _networkService.post(Urls.refreshToken, headers: {
//         'accept': 'text/plain',
//         'content-type': 'application/json',
//         'Platform': 'Mobile',
//         'LanguageCode': 'En'
//       }, body: {
//         "accessToken": EncryptionDecryptionFileManager.decryptAES(accessToken),
//         "refreshToken": EncryptionDecryptionFileManager.decryptAES(refreshToken)
//       });

//       if (response?.statusCode == ConstantKeys.successfullyApi200 ||
//           response?.statusCode == ConstantKeys.successfullyApi201) {
//         return right(refreshTokenFromJson(response?.data));
//       } else {
//         return left(ApiRequestFailure(
//             failureMsg: refreshTokenFromJson(response?.data).message));
//       }
//     } catch (e) {
//       return left(
//           ApiRequestFailure(failureMsg: NetworkExceptions.getDioException(e)));
//     }
//   }

//   static Future<bool> refreshToken() async {
//     bool success = false;
//     final Either<ApiRequestFailure, RefreshTokenResponseModel>
//         _refreshTokenResponse = await refreshTokenApi();

//     _refreshTokenResponse.fold((error) {
//       success = false;
//       debugPrint("----- refresh token failed  -----");
//       // refresh token is wrong
//       // accessToken = null;
//       LogOutManager().logOut();
//     }, (data) async {
//       success = true;
//       debugPrint("----- refresh token success  -----");
//       _storage.write(
//         ConstantKeys.token,
//         EncryptionDecryptionFileManager.encryptAES(
//             data.result?.accessToken ?? ""),
//       );
//       _storage.write(
//         ConstantKeys.refreshToken,
//         EncryptionDecryptionFileManager.encryptAES(
//             data.result?.refreshToken ?? ""),
//       );
//     });
//     return success;
//   }
// }
