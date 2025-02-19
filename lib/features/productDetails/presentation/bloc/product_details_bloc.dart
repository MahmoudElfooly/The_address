import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/features/cart/domain/entities/cart_item_entity.dart';
import 'package:the_address/features/productDetails/presentation/bloc/product_details_events.dart';
import 'package:the_address/features/productDetails/presentation/bloc/product_details_states.dart';

import '../../../cart/domain/useCase/cart_use_case.dart';
import '../../domain/mapper/product_to_cart_mapper.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final CartUseCase _cartUseCase;
  final ProductToCartItemMapper _productToCartItemMapper;

  ProductDetailBloc(this._cartUseCase, this._productToCartItemMapper)
      : super(const ProductDetailInitial()) {
    on<ChangeImageEvent>((event, emit) {
      emit(ProductDetailInitial(selectedImageIndex: event.selectedIndex));
    });

    on<AddToCartEvent>(_onAddToCart);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<ProductDetailState> emit) async {
    final CartItemEntity newCartItem =
        _productToCartItemMapper.convertProductToCartItem(event.product);
    final List<CartItemEntity> savedCartList = await getSavedCartItems();
    // Check if the item already exists in the cart
    int existingIndex =
        savedCartList.indexWhere((item) => item.id == newCartItem.id);
    if (existingIndex != -1) {
      savedCartList[existingIndex].quantity =
          savedCartList[existingIndex].quantity + 1;
    } else {
      savedCartList.add(newCartItem);
    }
    await _cartUseCase.saveToCartList(savedCartList);

    emit(ProductAddedToCartState());
  }

  Future<List<CartItemEntity>> getSavedCartItems() async {
    return await _cartUseCase.getCartList();
  }
}
