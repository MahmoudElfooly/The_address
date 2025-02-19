import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/core/servicesLocator/services_locator.dart';
import 'package:the_address/features/cart/domain/useCase/cart_use_case.dart';
import 'package:the_address/features/productDetails/domain/mapper/product_to_cart_mapper.dart';
import 'package:the_address/features/productDetails/presentation/screens/product_details_screen.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../bloc/product_details_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductItemEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(
          locator<CartUseCase>(), locator<ProductToCartItemMapper>()),
      child: ProductDetailScreen(product: product),
    );
  }
}
