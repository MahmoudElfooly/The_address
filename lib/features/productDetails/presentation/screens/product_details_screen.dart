import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_address/app_state/cart_count_cubit.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

import '../../../../commonComponents/widgets/cart_icon.dart';
import '../../../../uiHelper/app_theme.dart';
import '../bloc/product_details_bloc.dart';
import '../bloc/product_details_events.dart';
import '../bloc/product_details_states.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductItemEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      final selectedImageIndex =
          state is ProductDetailInitial ? state.selectedImageIndex : 0;
      final selectedImage = product.images[selectedImageIndex];
      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    selectedImage, // Use the selected image
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.45,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 50,
                    left: 25,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/Back.svg"),
                    ),
                  ),
                  Positioned(top: 50, right: 25, child: CartIcon()),
                ],
              ),
              // Product Name
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: DefaultThemeColors.grayFont,
                            ),
                          ),
                        ),
                        Text(
                          product.category.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: DefaultThemeColors.grayFont,
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 100,
                    autoPlay: false,
                    viewportFraction: 0.3,
                    enableInfiniteScroll: true,
                  ),
                  items: product.images.map((item) {
                    return GestureDetector(
                      onTap: () {
                        // Dispatch event to change the selected image
                        context.read<ProductDetailBloc>().add(
                              ChangeImageEvent(
                                product.images.indexOf(item),
                              ),
                            );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 17,
                    color: DefaultThemeColors.grayFont,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 70,
          child: BlocListener<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {
              if (state is ProductAddedToCartState) {
                context.read<CartCountCubit>().refreshCartCount();
              }
            },
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: state is ProductAddedToCartState
                    ? Colors.green
                    : DefaultThemeColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
              ),
              child: Text(
                state is ProductAddedToCartState
                    ? "Item Added To Cart"
                    : "Add to Cart",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                state is ProductAddedToCartState
                    ? () {}
                    : context
                        .read<ProductDetailBloc>()
                        .add(AddToCartEvent(product));
              },
            ),
          ),
        ),
      );
    });
  }
}
