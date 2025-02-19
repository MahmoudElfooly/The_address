import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AbstractNetworkService {
  Future<Either<Failure, Response>> get(url, {headers, query});
  Future<Either<Failure, Response>> post(url, {body, headers, query});
  Future<Either<Failure, Response>> delete(url, {body, headers, query});
  Future<Either<Failure, Response>> put(url, {body, headers, query});
  Future<Either<Failure, Response>> patch(url, {body, headers, query});
  String generateURLWithParams(Map<String, dynamic>? params, String api);
  String concatenateParams(Map<String, dynamic>? params, String api);
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
