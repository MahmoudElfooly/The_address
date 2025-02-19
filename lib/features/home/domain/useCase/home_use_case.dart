import 'package:the_address/features/home/domain/entities/category_entituy.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';
import 'package:the_address/features/home/domain/mapper/categories_mapper.dart';
import 'package:the_address/features/home/domain/mapper/products_mapper.dart';
import 'package:the_address/features/home/domain/repository/home_repository.dart';

abstract class HomeUseCase {
  Future<List<ProductItemEntity>> getProducts(
      {required int offset, required int limit});
  Future<List<CategoryItemEntity>> getCategories();
}

class HomeUseCaseImp implements HomeUseCase {
  final HomeRepository _repository;
  final ProductMapper _productMapper;
  final CategoryMapper _categoryMapper;

  HomeUseCaseImp(this._repository, this._productMapper, this._categoryMapper);

  @override
  Future<List<ProductItemEntity>> getProducts(
      {required int offset, required int limit}) async {
    final result = await _repository.getProducts(offset: offset, limit: limit);

    return result.fold(
      (failure) => [], // Directly return Empty List if there's an error
      (products) => _productMapper.productModelListToEntityList(
          products), // Return the list of transactions
    );
  }

  @override
  Future<List<CategoryItemEntity>> getCategories() async {
    final result = await _repository.getCategories();

    return result.fold(
      (failure) => [], // Directly return Empty List if there's an error
      (cat) => _categoryMapper.categoryModelListToEntityList(
          cat), // Return the list of transactions
    );
  }
}
