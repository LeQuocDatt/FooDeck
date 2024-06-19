part of 'search_page_bloc.dart';

@immutable
sealed class SearchPageEvent {}

class SearchPageInitialEvent extends SearchPageEvent {}

class SearchEvent extends SearchPageEvent {
  final String search;

  SearchEvent({required this.search});
}

class SearchPageNavigateToRestaurantPageEvent extends SearchPageEvent {
  final RestaurantModel restaurantModel;

  SearchPageNavigateToRestaurantPageEvent({required this.restaurantModel});
}
