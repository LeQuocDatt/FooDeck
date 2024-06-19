part of 'splash_page_bloc.dart';

@immutable
sealed class SplashPageState {}

final class SplashPageInitial extends SplashPageState {}

class SplashLoadingAnimationState extends SplashPageState {
  final bool animationFirstAndLast;
  final bool animation2;

  SplashLoadingAnimationState(
      {required this.animationFirstAndLast, required this.animation2});
}
