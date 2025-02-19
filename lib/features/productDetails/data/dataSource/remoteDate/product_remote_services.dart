import 'package:dartz/dartz.dart';

import '../../../../../core/networkService/base_service.dart';
import '../../../../../core/networkService/dio/network_exceptions.dart';
import '../../../../../core/networkService/dio/network_service.dart';
import '../../../../../core/networkService/header.dart';
import '../../../../../core/networkService/models/api_request_failur.dart';
import '../../../../../utils/constant_keywords.dart';
import '../../../../../utils/urls.dart';
import '../../models/update_product_payload.dart';

class ProductRemoteService extends BaseService {
  final NetworkService networkService = NetworkService();
  Future<Either<ApiRequestFailure, bool>> updateProduct(
      {required int id, required UpdateProductPayload payload}) async {
    String url = "${Urls.updateProduct}$id";

    try {
      final result = await networkService.put(
        url,
        headers: HeaderData.getHeader(),
        query: null,
        body: payload.toJson(),
      );

      return result.fold(
        (failure) {
          return Left(ApiRequestFailure(failureMsg: failure.message));
        },
        (response) {
          // Check if the response is successful
          if (response.statusCode == ConstantKeys.successfullyApi200 ||
              response.statusCode == ConstantKeys.successfullyApi201) {
            return Right(true);
          } else {
            // Handle non-200/201 responses
            return Left(ApiRequestFailure(failureMsg: 'Unknown error'));
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
