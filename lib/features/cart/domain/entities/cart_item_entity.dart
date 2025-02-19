import 'package:hive/hive.dart';

part 'cart_item_entity.g.dart';

@HiveType(typeId: 0)
class CartItemEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final num price;

  @HiveField(4)
  int quantity;

  CartItemEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
  CartItemEntity copyWith({
    int? id,
    String? imageUrl,
    String? title,
    num? price,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
