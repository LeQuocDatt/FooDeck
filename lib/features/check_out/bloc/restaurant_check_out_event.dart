part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutEvent {}

class RestaurantCheckOutInitialEvent extends RestaurantCheckOutEvent {}

class RestaurantCheckOutNavigateToCreateCardEvent
    extends RestaurantCheckOutEvent {}

class RestaurantCheckOutNavigateToMapEvent extends RestaurantCheckOutEvent {}

class RestaurantCheckOutNavigateToOrderCompleteEvent
    extends RestaurantCheckOutEvent {
  final BuildContext context;

  RestaurantCheckOutNavigateToOrderCompleteEvent({required this.context});
}
