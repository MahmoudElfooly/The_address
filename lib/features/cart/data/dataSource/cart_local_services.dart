import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../core/localStorageManager/local_storage_manager.dart';

abstract class CartLocalData {
  List<CartItemEntity> getLocalCart();
  void saveToLocalCart(List<CartItemEntity> list);
}

class CartLocalDataImp implements CartLocalData {
  @override
  List<CartItemEntity> getLocalCart() {
    return LocalStorageManager.getList<CartItemEntity>(
            DefaultsKeys.cartItems) ??
        [];
  }

  @override
  void saveToLocalCart(List<CartItemEntity> list) {
    LocalStorageManager.saveList(DefaultsKeys.cartItems, list);
  }
}
