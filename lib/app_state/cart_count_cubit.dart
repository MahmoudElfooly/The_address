import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/cart/domain/useCase/cart_use_case.dart';

class CartCountCubit extends Cubit<int> {
  final CartUseCase _cartUseCase;

  CartCountCubit(this._cartUseCase) : super(0) {
    _loadInitialCartCount();
  }

  Future<void> _loadInitialCartCount() async {
    final cartCount = await _cartUseCase.getCartCount();
    emit(cartCount);
  }

  Future<void> refreshCartCount() async {
    final cartCount = await _cartUseCase.getCartCount();
    emit(cartCount);
  }
}
