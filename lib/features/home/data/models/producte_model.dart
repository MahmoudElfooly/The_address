import 'category_model.dart';

List<ProductItemModel> productItemFromJson(dynamic json) {
  return (json as List).map((e) => ProductItemModel.fromJson(e)).toList();
}

class ProductItemModel {
  int id;
  String title;
  int price;
  String description;
  List<String> images;
  String creationAt;
  String updatedAt;
  CategoryItemModel category;

  ProductItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        creationAt: json["creationAt"],
        updatedAt: json["updatedAt"],
        category: CategoryItemModel.fromJson(json["category"]),
      );
}
