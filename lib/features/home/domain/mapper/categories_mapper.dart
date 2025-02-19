import 'package:the_address/features/home/data/models/producte_model.dart';
import 'package:the_address/features/home/domain/entities/category_entituy.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

abstract class ProductMapper {
  ProductItemEntity productModelToEntity(ProductItemModel model);
  List<ProductItemEntity> productModelListToEntityList(
      List<ProductItemModel> models);
}

class ProductMapperImp implements ProductMapper {
  @override
  ProductItemEntity productModelToEntity(ProductItemModel model) {
    return ProductItemEntity(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      images: model.images,
      creationAt: model.creationAt,
      updatedAt: model.updatedAt,
      category: CategoryItemEntity(
        id: model.category.id,
        name: model.category.name,
        image: model.category.image,
        creationAt: model.category.creationAt,
        updatedAt: model.category.updatedAt,
      ),
    );
  }

  @override
  List<ProductItemEntity> productModelListToEntityList(
      List<ProductItemModel> models) {
    return models.map(productModelToEntity).toList();
  }
}
