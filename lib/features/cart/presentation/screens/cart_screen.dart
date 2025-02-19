import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_address/core/localStorageManager/local_storage_manager.dart';
import 'package:the_address/core/servicesLocator/services_locator.dart';
import 'package:the_address/features/cart/domain/useCase/cart_use_case.dart';

import '../../../../app_state/cart_count_cubit.dart';
import '../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../uiHelper/app_theme.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_events.dart';
import '../bloc/cart_states.dart';
import 'order_confirmed_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset("assets/GrayBack.svg"),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            CartBloc(locator<CartUseCase>())..add(LoadCartItems()),
        child: BlocBuilder<CartBloc, CartChangeItemState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.network(item.imageUrl, width: 60),
                          title: Text(item.title),
                          subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocListener<CartBloc, CartChangeItemState>(
                                listener: (context, state) {
                                  context
                                      .read<CartCountCubit>()
                                      .refreshCartCount();
                                },
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(DecreaseQuantity(item));
                                  },
                                ),
                              ),
                              Text("${item.quantity}"),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(IncreaseQuantity(item));
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(RemoveItem(item));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Order Info",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildPriceRow("Subtotal", state.subtotal),
                      _buildPriceRow("Shipping Cost", state.shippingCost),
                      _buildPriceRow("Total", state.total, isTotal: true),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: DefaultThemeColors.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
          ),
          child: const Text(
            "Checkout",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            LocalStorageManager.deleteData(DefaultsKeys.cartItems);
            context.read<CartCountCubit>().refreshCartCount();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmedScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

//Use This as a method to rebuild every change
  Widget _buildPriceRow(String title, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
