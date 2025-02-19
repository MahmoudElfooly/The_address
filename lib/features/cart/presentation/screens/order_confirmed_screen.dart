import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_address/uiHelper/app_theme.dart';

import '../../../home/presentation/screens/home_screen.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment(0, 0.45),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/curvedLines.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 232,
                child: SvgPicture.asset(
                  'assets/successPhone.svg', // Replace with actual asset
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              // Order Confirmation Text
              const Text(
                'Order Confirmed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Your order has been confirmed, we will send you a confirmation email shortly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
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
            "Continue Shopping",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false, // Remove all previous routes
            );
          },
        ),
      ),
    );
  }
}
