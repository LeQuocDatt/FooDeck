part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageEvent {}

class RestaurantPageInitialEvent extends RestaurantPageEvent {}

class RestaurantPageShareEvent extends RestaurantPageEvent {}

class RestaurantPageReportEvent extends RestaurantPageEvent {}

class RestaurantPageSetReviewEvent extends RestaurantPageEvent {
  final String review;

  RestaurantPageSetReviewEvent({required this.review});
}

class RestaurantPageSetRateEvent extends RestaurantPageEvent {
  final double rate;

  RestaurantPageSetRateEvent({required this.rate});
}

class RestaurantPageSentReviewEvent extends RestaurantPageEvent {
  final BuildContext context;
  final RestaurantModel restaurant;

  RestaurantPageSentReviewEvent(
      {required this.context, required this.restaurant});
}

class RestaurantPageMapEvent extends RestaurantPageEvent {}

class RestaurantPageNavigateToAddonEvent extends RestaurantPageEvent {
  final FoodItems foodItems;

  RestaurantPageNavigateToAddonEvent({required this.foodItems});
}
