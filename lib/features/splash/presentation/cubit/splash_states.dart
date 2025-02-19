abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashFailure extends SplashState {
  final String error;
  SplashFailure({required this.error});
}
