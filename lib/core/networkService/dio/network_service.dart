import 'package:dartz/dartz.dart'; // For Either type
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/urls.dart';
import 'abstract_network_service.dart';
import 'logging_interceptor.dart';
import 'network_exceptions.dart';

class NetworkService implements AbstractNetworkService {
  Dio? _dio;

  // Initialize Dio
  NetworkService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 120),
        receiveTimeout: Duration(seconds: 120),
        baseUrl: Urls.baseUrl,
      ),
    );

    // Add logging interceptor in debug mode
    if (!kReleaseMode) {
      _dio?.interceptors.add(LoggingInterceptor());
    }
  }

  @override
  Future<Either<Failure, Response>> delete(url, {body, headers, query}) async {
    try {
      final response = await _dio!.delete(
        url,
        data: body,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioError catch (e) {
      return Left(Failure(NetworkExceptions.getDioException(e)));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Response>> get(url, {headers, query}) async {
    try {
      final response = await _dio!.get(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioError catch (e) {
      return Left(Failure(NetworkExceptions.getDioException(e)));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Response>> post(url, {body, headers, query}) async {
    try {
      final response = await _dio!.post(
        url,
        data: body,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioError catch (e) {
      return Left(Failure(NetworkExceptions.getDioException(e)));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Response>> put(url, {body, headers, query}) async {
    try {
      final response = await _dio!.put(
        url,
        data: body,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioError catch (e) {
      return Left(Failure(NetworkExceptions.getDioException(e)));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Response>> patch(url, {body, headers, query}) async {
    try {
      final response = await _dio!.patch(
        url,
        data: body,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return Right(response);
    } on DioError catch (e) {
      return Left(Failure(NetworkExceptions.getDioException(e)));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  String generateURLWithParams(Map<String, dynamic>? params, String api) {
    api = (params != null && params.isNotEmpty) ? '$api?' : api;
    params!.forEach((key, val) {
      if (val != null) {
        api += "$key=${val.toString()}&";
      }
    });
    if (api.contains('&')) {
      api = api.substring(0, api.length - 1);
    }
    return api;
  }

  @override
  String concatenateParams(Map<String, dynamic>? params, String api) {
    api = (params != null && params.isNotEmpty) ? '$api/' : api;
    params!.forEach((key, val) {
      if (val != null) {
        api += '$val/';
      }
    });
    return api;
  }
}
