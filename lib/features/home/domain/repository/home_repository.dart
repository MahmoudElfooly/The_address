import 'package:dartz/dartz.dart';
import 'package:the_address/features/home/data/models/category_model.dart';

import '../../../../core/networkService/models/api_request_failur.dart';
import '../../data/models/producte_model.dart';

abstract class HomeRepository {
  Future<Either<ApiRequestFailure, List<ProductItemModel>>> getProducts(
      {required int offset, required int limit});
  Future<Either<ApiRequestFailure, List<CategoryItemModel>>> getCategories();
}
