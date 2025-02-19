import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:the_address/features/home/data/models/category_model.dart';

import '../../../../../core/networkService/base_service.dart';
import '../../../../../core/networkService/dio/network_exceptions.dart';
import '../../../../../core/networkService/dio/network_service.dart';
import '../../../../../core/networkService/header.dart';
import '../../../../../core/networkService/models/api_request_failur.dart';
import '../../../../../utils/constant_keywords.dart';
import '../../../../../utils/urls.dart';
import '../../models/producte_model.dart';

class HomeRemoteServices extends BaseService {
  final NetworkService networkService = NetworkService();

  Future<Either<ApiRequestFailure, List<ProductItemModel>>> getProducts(
      {required int offset, required int limit}) async {
    String url = networkService.generateURLWithParams(
        {"offset": offset, "limit": limit}, Urls.getProducts);
    try {
      final result = await networkService.get(
        url,
        headers: HeaderData.getHeader(),
        query: null,
      );

      return result.fold(
        (failure) {
          return Left(ApiRequestFailure(failureMsg: failure.message));
        },
        (response) {
          // Check if the response is successful
          if (response.statusCode == ConstantKeys.successfullyApi200 ||
              response.statusCode == ConstantKeys.successfullyApi201) {
            // Parse the response body
            dynamic result;
            if (response.data is List) {
              result = response.data;
            } else {
              // Handle unexpected response type
              return Left(
                  ApiRequestFailure(failureMsg: 'Invalid response type'));
            }
            final res = productItemFromJson(result);
            return Right(res);
          } else {
            // Handle non-200/201 responses
            final result = json.decode(response.toString());
            return Left(ApiRequestFailure(
                failureMsg: result['message'] ?? 'Unknown error'));
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
          ApiRequestFailure(failureMsg: NetworkExceptions.getDioException(e)));
    }
  }

  Future<Either<ApiRequestFailure, List<CategoryItemModel>>>
      getCategories() async {
    String url = Urls.getCategories;
    try {
      final result = await networkService.get(
        url,
        headers: HeaderData.getHeader(),
        query: null,
      );

      return result.fold(
        (failure) {
          return Left(ApiRequestFailure(failureMsg: failure.message));
        },
        (response) {
          // Check if the response is successful
          if (response.statusCode == ConstantKeys.successfullyApi200 ||
              response.statusCode == ConstantKeys.successfullyApi201) {
            // Parse the response body
            dynamic result;
            if (response.data is List) {
              result = response.data;
            } else {
              // Handle unexpected response type
              return Left(
                  ApiRequestFailure(failureMsg: 'Invalid response type'));
            }
            final res = categoryItemModelFromJson(result);
            return Right(res);
          } else {
            // Handle non-200/201 responses
            final result = json.decode(response.toString());
            return Left(ApiRequestFailure(
                failureMsg: result['message'] ?? 'Unknown error'));
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
          ApiRequestFailure(failureMsg: NetworkExceptions.getDioException(e)));
    }
  }
}
