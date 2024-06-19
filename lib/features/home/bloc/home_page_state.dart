part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageSelectIndexState extends HomePageState {
  final int index;

  HomePageSelectIndexState({required this.index});
}
