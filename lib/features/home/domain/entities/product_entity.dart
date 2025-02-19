import 'category_entituy.dart';

class ProductItemEntity {
  final int id;
  final String title;
  final num price;
  final String description;
  final List<String> images;
  final String creationAt;
  final String updatedAt;
  final CategoryItemEntity category;

  ProductItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  ProductItemEntity copyWith({
    int? id,
    String? title,
    num? price,
    String? description,
    List<String>? images,
    String? creationAt,
    String? updatedAt,
    CategoryItemEntity? category,
  }) {
    return ProductItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? List.from(this.images), // Ensure immutability
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }
}
