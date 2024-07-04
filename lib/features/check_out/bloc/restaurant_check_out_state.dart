part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutState {}

final class RestaurantCheckOutInitial extends RestaurantCheckOutState {}

class RestaurantCheckOutLoadedState extends RestaurantCheckOutState {
  final String? address;
  final CameraPosition initialCameraPosition;

  RestaurantCheckOutLoadedState(
      {required this.address, required this.initialCameraPosition});
}

class RestaurantCheckOutNavigateToCreateCardState
    extends RestaurantCheckOutState {}

class RestaurantCheckOutNavigateToMapState extends RestaurantCheckOutState {}

class RestaurantCheckOutNavigateToOrderCompleteState
    extends RestaurantCheckOutState {}
