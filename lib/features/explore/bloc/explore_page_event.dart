part of 'explore_page_bloc.dart';

sealed class ExplorePageEvent {}

class ExplorePageInitialEvent extends ExplorePageEvent {}

class ExplorePageSearchNavigateEvent extends ExplorePageEvent {}

class ExplorePageNavigateEvent extends ExplorePageEvent {
  final RestaurantModel restaurantModel;

  ExplorePageNavigateEvent({required this.restaurantModel});
}

class ExplorePageCartNavigateEvent extends ExplorePageEvent {}

class ExplorePageLikeEvent extends ExplorePageEvent {
  final RestaurantModel saveFood;

  ExplorePageLikeEvent({required this.saveFood});
}
