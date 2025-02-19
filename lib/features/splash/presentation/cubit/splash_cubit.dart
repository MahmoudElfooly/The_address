import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/features/splash/presentation/cubit/splash_states.dart';

import '../../../../core/authManager/auth_manager.dart';
import '../../../../core/baseRepo/bearer_token_repo.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initializeApp() async {
    emit(SplashLoading());
    // await setDefaultUser();
    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second delay
    emit(SplashSuccess());
  }

  // This Func Act as Login
  Future<void> setDefaultUser() async {
    if (!AuthManager.isLogged()) {
      await BearerTokenRepo.setBearerToken("user1");
    }
  }
}
