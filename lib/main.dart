import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_address/features/cart/domain/useCase/cart_use_case.dart';

import 'app_state/cart_count_cubit.dart';
import 'core/environment/environment.dart';
import 'core/localStorageManager/local_storage_keys.dart';
import 'core/localStorageManager/register_adapter.dart';
import 'core/servicesLocator/services_locator.dart';
import 'features/splash/presentation/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: Environment.fileName);
  await Hive.initFlutter();
  HiveRegisterAdapter.registerAdapters();
  await Hive.openBox(DefaultsKeys.hiveBoxKey);
  setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CartCountCubit(locator<CartUseCase>())), // Provide globally
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
