import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';
import 'package:the_address/features/cart/domain/repository/cart_repo.dart';

abstract class CartUseCase {
  Future<List<CartItemEntity>> getCartList();
  Future<void> saveToCartList(List<CartItemEntity> list);
  Future<int> getCartCount();
}

class CartUseCaseImp implements CartUseCase {
  final CartRepository _cartRepository;
  CartUseCaseImp(this._cartRepository);

  @override
  Future<List<CartItemEntity>> getCartList() async {
    final result = await _cartRepository.getCartList();

    return result.fold(
      (failure) => [],
      (cartList) => cartList,
    );
  }

  @override
  Future<void> saveToCartList(List<CartItemEntity> list) async {
    await _cartRepository.saveToCartList(list);
  }

  @override
  Future<int> getCartCount() async {
    final cartList = await getCartList();
    return cartList.fold<int>(0, (sum, item) => sum + item.quantity);
  }
}
