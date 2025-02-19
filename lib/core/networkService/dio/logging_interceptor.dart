import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../authManager/auth_manager.dart';

class LoggingInterceptor extends dio.Interceptor {
  final Dio api = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final data = options.data;
    if (data != null) {
      log(data.toString(),
          time: DateTime.now(), name: "Requesting => ${options.path}");
    } else {
      log(options.method,
          time: DateTime.now(), name: "Requesting => ${options.path}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(jsonEncode(response.data),
        time: DateTime.now(),
        name: "Response: ${response.requestOptions.path}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    int status = err.response?.statusCode ?? 0;
    if (status == 401) {
      //trying to logout if code is 401
      // DialogsBuilder.apiErrorSnackBar("Session Expired");

      AuthManager.logout();
      //
      // debugPrint("----- Error : 401 -----");
      // debugPrint(
      //     "----- Error happened while excuting : -----${err.requestOptions.method.toString()}");
      // if (await _storage.read(ConstantKeys.refreshToken) != null) {
      //   // LogOutManager.logOut();
      //
      //   if (await RefreshToken.refreshToken()) {
      //     return handler.resolve(await _retry(err.requestOptions));
      //   }
      // } else {
      //   if(_storage.read(ConstantKeys.deviceId)!= null ||
      //       _storage.read(ConstantKeys.deviceId) != ""){
      //     LogOutManager().logOut();
      //   }else{
      //
      //   }
      // }
    }

    log(jsonEncode(err.response?.data),
        time: DateTime.now(), name: "Error: ${err.requestOptions.path}");
    log("Error: ${err.error?.toString()}");
    return handler.next(err);
    // return super.onError(err, handler);
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   debugPrint(
  //       "----- retry sending request : ----- ${requestOptions.method.toString()}");
  //
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: HeaderData.getHeader(),
  //     //requestOptions.headers,
  //   );
  //   return api.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }
}
