import 'package:dartz/dartz.dart';

import '../../../../core/networkService/models/api_request_failur.dart';
import '../../data/models/update_product_payload.dart';

abstract class ProductRepository {
  Future<Either<ApiRequestFailure, bool>> updateProduct(
      {required int id, required UpdateProductPayload payload});
}
