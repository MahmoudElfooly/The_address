import 'package:hive_flutter/hive_flutter.dart';

import '../../features/cart/domain/entities/cart_item_entity.dart';

class HiveRegisterAdapter {
  static void registerAdapters() {
    Hive.registerAdapter(CartItemEntityAdapter());
  }
}
