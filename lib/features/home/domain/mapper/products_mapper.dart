import 'package:the_address/features/home/data/models/category_model.dart';
import 'package:the_address/features/home/domain/entities/category_entituy.dart';

abstract class CategoryMapper {
  CategoryItemEntity categoryModelToEntity(CategoryItemModel model);
  List<CategoryItemEntity> categoryModelListToEntityList(
      List<CategoryItemModel> models);
}

class CategoryMapperImp implements CategoryMapper {
  @override
  CategoryItemEntity categoryModelToEntity(CategoryItemModel model) {
    return CategoryItemEntity(
      id: model.id,
      name: model.name,
      image: model.image,
      creationAt: model.creationAt,
      updatedAt: model.updatedAt,
    );
  }

  @override
  List<CategoryItemEntity> categoryModelListToEntityList(
      List<CategoryItemModel> models) {
    return models.map(categoryModelToEntity).toList();
  }
}
