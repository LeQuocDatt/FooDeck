part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutEvent {}

class RestaurantCheckOutInitialEvent extends RestaurantCheckOutEvent {}

class RestaurantCheckOutNavigateToCreateCardEvent
    extends RestaurantCheckOutEvent {}

class RestaurantCheckOutSearchEvent extends RestaurantCheckOutEvent {
  final String search;

  RestaurantCheckOutSearchEvent({required this.search});
}

class RestaurantCheckOutPickAddressEvent extends RestaurantCheckOutEvent {
  final CameraPosition initialCameraPosition;
  final String place;

  RestaurantCheckOutPickAddressEvent(
      {required this.initialCameraPosition, required this.place});
}

class RestaurantCheckOutRelocateAddressEvent extends RestaurantCheckOutEvent {}

class RestaurantCheckOutSaveAddressEvent extends RestaurantCheckOutEvent {
  final CameraPosition initialCameraPosition;
  final String place;

  RestaurantCheckOutSaveAddressEvent(
      {required this.initialCameraPosition, required this.place});
}

class RestaurantCheckOutNavigateToOrderCompleteEvent
    extends RestaurantCheckOutEvent {
  final BuildContext context;

  RestaurantCheckOutNavigateToOrderCompleteEvent({required this.context});
}
