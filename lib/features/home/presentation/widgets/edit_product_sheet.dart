import 'package:flutter/material.dart';

import '../../../../uiHelper/app_theme.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_events.dart';

void showEditProductBottomSheet(
    BuildContext context, ProductItemEntity product, HomeBloc bloc) {
  final TextEditingController titleController =
      TextEditingController(text: product.title);
  final TextEditingController priceController =
      TextEditingController(text: '${product.price.toStringAsFixed(2)}');
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close Button and Title
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Text(
                          "Edit Product",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Title Label
                Text("Title",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),

                // Title Input Field
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                SizedBox(height: 20),

                // Price Label
                Text("Price",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),

                // Price Input Field
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "1400 EGP",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                SizedBox(height: 40),

                // Update Button
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 70,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: DefaultThemeColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero))),
              child: const Text("Update",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                final updatedProduct = product.copyWith(
                    title: titleController.text,
                    price: double.parse(priceController.text));
                bloc.add(UpdateProductEvent(product: updatedProduct));
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    },
  );
}
