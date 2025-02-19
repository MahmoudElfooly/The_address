import 'package:flutter/material.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';

import '../../../productDetails/presentation/screens/product_details_page.dart';
import '../bloc/home_bloc.dart';
import 'edit_product_sheet.dart';

class ProductCard extends StatelessWidget {
  final ProductItemEntity product;
  final HomeBloc bloc;

  const ProductCard({super.key, required this.product, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Same radius for card & image
            ),
            elevation: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15), // Ensures the image is clipped
                  child: Image.network(
                    product.images.first,
                    fit: BoxFit.cover, // Ensures it fills the card
                    width: double.infinity, // Takes full width
                    height: 203, // Adjust height as needed
                  ),
                ),
                Positioned(
                  top: 10, // Adjust position
                  right: 10, // Adjust position
                  child: Builder(
                    builder: (newContext) => GestureDetector(
                      onTap: () {
                        showEditProductBottomSheet(newContext, product, bloc);
                      },
                      child: Image.asset(
                        'assets/edit-2.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
