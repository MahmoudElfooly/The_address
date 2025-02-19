List<CategoryItemModel> categoryItemModelFromJson(dynamic json) {
  return (json as List).map((e) => CategoryItemModel.fromJson(e)).toList();
}

class CategoryItemModel {
  int id;
  String name;
  String image;
  String creationAt;
  String updatedAt;

  CategoryItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: json["creationAt"],
        updatedAt: json["updatedAt"],
      );
}
