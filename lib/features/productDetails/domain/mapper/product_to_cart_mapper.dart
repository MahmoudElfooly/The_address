import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

abstract class ProductToCartItemMapper {
  CartItemEntity convertProductToCartItem(ProductItemEntity product);
}

class ProductToCartItemMapperImp implements ProductToCartItemMapper {
  @override
  CartItemEntity convertProductToCartItem(ProductItemEntity model) {
    return CartItemEntity(
      id: model.id,
      imageUrl: model.images.first,
      title: model.title,
      price: model.price,
    );
  }
}
