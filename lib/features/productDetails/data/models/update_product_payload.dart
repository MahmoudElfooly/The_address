import 'dart:convert';

String updateProductPayloadToJson(UpdateProductPayload data) =>
    json.encode(data.toJson());

class UpdateProductPayload {
  String title;
  num price;
  List<String> images;

  UpdateProductPayload({
    required this.title,
    required this.price,
    required this.images,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
