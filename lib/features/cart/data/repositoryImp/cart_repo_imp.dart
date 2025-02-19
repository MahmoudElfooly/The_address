import 'package:dartz/dartz.dart';
import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/networkService/models/api_request_failur.dart';
import '../../domain/repository/cart_repo.dart';
import '../dataSource/cart_local_services.dart';

class CartRepositoryImp implements CartRepository {
  final CartLocalData _cartLocalData = CartLocalDataImp();

  @override
  Future<Either<ApiRequestFailure, List<CartItemEntity>>> getCartList() async {
    final data = _cartLocalData.getLocalCart();
    return right(data);
  }

  @override
  Future<void> saveToCartList(List<CartItemEntity> list) async {
    _cartLocalData.saveToLocalCart(list);
  }
}
