// Events
import 'package:the_address/features/home/domain/entities/product_entity.dart';

abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class LoadMoreProducts extends HomeEvent {}

class UpdateProductEvent extends HomeEvent {
  final ProductItemEntity product;

  UpdateProductEvent({required this.product});
}
