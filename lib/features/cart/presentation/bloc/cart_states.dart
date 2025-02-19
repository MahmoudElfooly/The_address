import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_item_entity.dart';

// Default cart state
class CartChangeItemState extends Equatable {
  final List<CartItemEntity> items;
  final double subtotal;
  final double shippingCost;
  final double total;

  const CartChangeItemState({
    this.items = const [],
    this.subtotal = 0.0,
    this.shippingCost = 10.0,
    this.total = 0.0,
  });

  CartChangeItemState copyWith({
    List<CartItemEntity>? items,
    double? subtotal,
    double? shippingCost,
    double? total,
  }) {
    return CartChangeItemState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [items, subtotal, shippingCost, total];
}

// New state for removing an item
class CartRemoveItem extends CartChangeItemState {}
