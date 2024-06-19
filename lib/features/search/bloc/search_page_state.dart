part of 'search_page_bloc.dart';

@immutable
sealed class SearchPageState {}

final class SearchPageInitial extends SearchPageState {}

class SearchState extends SearchPageState {
  final List<RestaurantModel> filterItems;

  SearchState({required this.filterItems});
}

class SearchPageNavigateToRestaurantPageState extends SearchPageState {}
