import 'package:dartz/dartz.dart';
import 'package:the_address/core/networkService/models/api_request_failur.dart';
import 'package:the_address/features/productDetails/data/dataSource/remoteDate/product_remote_services.dart';

import '../../domain/repository/product_repo.dart';
import '../models/update_product_payload.dart';

class ProductRepositoryImp implements ProductRepository {
  final ProductRemoteService _productRemoteService = ProductRemoteService();
  @override
  Future<Either<ApiRequestFailure, bool>> updateProduct(
      {required int id, required UpdateProductPayload payload}) async {
    final response =
        await _productRemoteService.updateProduct(id: id, payload: payload);
    return response.fold((error) {
      return left(ApiRequestFailure(failureMsg: error.failureMsg));
    }, (data) async {
      return right(data);
    });
  }
}
