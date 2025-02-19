import 'package:equatable/equatable.dart';

//States
abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {
  final int selectedImageIndex;

  const ProductDetailInitial({this.selectedImageIndex = 0});

  @override
  List<Object?> get props => [selectedImageIndex];
}

class ProductAddedToCartState extends ProductDetailState {}
