import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_address/features/cart/presentation/screens/cart_screen.dart';

import '../../app_state/cart_count_cubit.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCountCubit, int>(builder: (context, cartCount) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
          child: Stack(
            children: [
              SvgPicture.asset("assets/cart.svg"), // Cart Icon
              cartCount > 0
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(
                            4), // Padding for better appearance
                        decoration: BoxDecoration(
                          color: Colors.red, // Badge background color
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 22,
                          minHeight: 22,
                        ),
                        child: Center(
                          child: Text(
                            '$cartCount', // Dynamic badge count
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ));
    });
  }
}
