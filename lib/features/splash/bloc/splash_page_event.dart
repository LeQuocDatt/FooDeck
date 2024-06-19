part of 'splash_page_bloc.dart';

@immutable
sealed class SplashPageEvent {}

class SplashPageInitialEvent extends SplashPageEvent {
  final BuildContext context;

  SplashPageInitialEvent({required this.context});
}
