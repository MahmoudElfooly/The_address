import 'package:dartz/dartz.dart';
import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/networkService/models/api_request_failur.dart';

abstract class CartRepository {
  Future<Either<ApiRequestFailure, List<CartItemEntity>>> getCartList();
  Future<void> saveToCartList(List<CartItemEntity> list);
}
