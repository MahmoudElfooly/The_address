import 'package:the_address/features/home/domain/entities/category_entituy.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryItemEntity> categories;
  final List<ProductItemEntity> products;
  final bool hasMore; // Track if more data is available

  HomeLoaded(
      {required this.categories,
      required this.products,
      required this.hasMore});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
