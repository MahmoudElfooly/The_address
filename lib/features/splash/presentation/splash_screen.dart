import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/screens/home_screen.dart';
import 'cubit/splash_cubit.dart';
import 'cubit/splash_states.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initializeApp(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is SplashFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              'assets/Logo.png', // Path to your splash screen logo
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
