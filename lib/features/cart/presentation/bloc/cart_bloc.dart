import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/features/cart/domain/useCase/cart_use_case.dart';

import '../../domain/entities/cart_item_entity.dart';
import 'cart_events.dart';
import 'cart_states.dart';

class CartBloc extends Bloc<CartEvent, CartChangeItemState> {
  final CartUseCase _cartUseCase;

  CartBloc(this._cartUseCase) : super(const CartChangeItemState()) {
    on<LoadCartItems>(_onLoadCartItems);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  // Load cart items from local storage
  Future<void> _onLoadCartItems(
      LoadCartItems event, Emitter<CartChangeItemState> emit) async {
    final savedItems = await _cartUseCase.getCartList();
    _updateCart(emit, savedItems, saveToStorage: false);
  }

  // Add an item to the cart and save to local storage
  Future<void> _onAddItem(
      AddItem event, Emitter<CartChangeItemState> emit) async {
    final updatedItems = List<CartItemEntity>.from(state.items);

    final index = updatedItems.indexWhere((item) => item.id == event.item.id);
    if (index != -1) {
      // If item already exists, increase quantity
      updatedItems[index] = updatedItems[index].copyWith(
        quantity: updatedItems[index].quantity + 1,
      );
    } else {
      // Otherwise, add the new item
      updatedItems.add(event.item);
    }

    await _updateCart(emit, updatedItems);
  }

  // Remove an item from the cart and update local storage
  Future<void> _onRemoveItem(
      RemoveItem event, Emitter<CartChangeItemState> emit) async {
    final updatedItems = List<CartItemEntity>.from(state.items)
      ..removeWhere((item) => item.id == event.item.id);

    await _updateCart(emit, updatedItems);

    // emit(CartRemoveItem());
  }

  // Increase item quantity and save to storage
  Future<void> _onIncreaseQuantity(
      IncreaseQuantity event, Emitter<CartChangeItemState> emit) async {
    final updatedItems = state.items.map((item) {
      if (item.id == event.item.id) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    await _updateCart(emit, updatedItems);
  }

  // Decrease item quantity (but not below 1) and save to storage
  Future<void> _onDecreaseQuantity(
      DecreaseQuantity event, Emitter<CartChangeItemState> emit) async {
    final updatedItems = state.items.map((item) {
      if (item.id == event.item.id && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    await _updateCart(emit, updatedItems);
  }

  // Update the state and save cart to local storage
  Future<void> _updateCart(
      Emitter<CartChangeItemState> emit, List<CartItemEntity> updatedItems,
      {bool saveToStorage = true}) async {
    final subtotal = updatedItems.fold(
        0.0, (sum, item) => sum + (item.price * item.quantity));
    final total = subtotal + state.shippingCost;

    emit(state.copyWith(items: updatedItems, subtotal: subtotal, total: total));

    if (saveToStorage) {
      await _cartUseCase.saveToCartList(updatedItems);
    }
  }
}
