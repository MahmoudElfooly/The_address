import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_item_entity.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartEvent {}

class AddItem extends CartEvent {
  final CartItemEntity item;

  AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CartEvent {
  final CartItemEntity item;

  RemoveItem(this.item);

  @override
  List<Object> get props => [item];
}

class IncreaseQuantity extends CartEvent {
  final CartItemEntity item;

  IncreaseQuantity(this.item);

  @override
  List<Object> get props => [item];
}

class DecreaseQuantity extends CartEvent {
  final CartItemEntity item;

  DecreaseQuantity(this.item);

  @override
  List<Object> get props => [item];
}
