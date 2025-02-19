import 'package:equatable/equatable.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

//Events

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeImageEvent extends ProductDetailEvent {
  final int selectedIndex;

  ChangeImageEvent(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class AddToCartEvent extends ProductDetailEvent {
  final ProductItemEntity product;

  AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}
