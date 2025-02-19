import 'package:the_address/features/productDetails/domain/repository/product_repo.dart';

import '../../data/models/update_product_payload.dart';

abstract class ProductUseCase {
  Future<bool> updateProduct(
      {required int id, required UpdateProductPayload payload});
}

class ProductUseCaseImp implements ProductUseCase {
  final ProductRepository _repository;

  ProductUseCaseImp(this._repository);

  @override
  Future<bool> updateProduct(
      {required int id, required UpdateProductPayload payload}) async {
    final result = await _repository.updateProduct(id: id, payload: payload);

    return result.fold(
      (failure) => false,
      (success) => success,
    );
  }
}
