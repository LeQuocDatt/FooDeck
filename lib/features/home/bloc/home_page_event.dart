part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class HomePageInitialEvent extends HomePageEvent {}

class HomePageSelectIndexEvent extends HomePageEvent {
  final int index;

  HomePageSelectIndexEvent({required this.index});
}
