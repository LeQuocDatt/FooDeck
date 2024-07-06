part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutState {}

class RestaurantCheckOutActionState extends RestaurantCheckOutState {
  final CameraPosition initialCameraPosition;
  final String place;

  RestaurantCheckOutActionState(
      {required this.initialCameraPosition, required this.place});
}

final class RestaurantCheckOutInitial extends RestaurantCheckOutState {}

class RestaurantCheckOutLoadedState extends RestaurantCheckOutActionState {
  RestaurantCheckOutLoadedState(
      {required super.initialCameraPosition, required super.place});
}

class RestaurantCheckOutSearchState extends RestaurantCheckOutState {
  final String search;
  final List<AddressModel> responses;

  RestaurantCheckOutSearchState(
      {required this.search, required this.responses});
}

class RestaurantCheckOutRelocateAddressState
    extends RestaurantCheckOutActionState {
  RestaurantCheckOutRelocateAddressState(
      {required super.initialCameraPosition, required super.place});
}

class RestaurantCheckOutSaveAddressState extends RestaurantCheckOutActionState {
  RestaurantCheckOutSaveAddressState(
      {required super.initialCameraPosition, required super.place});
}

class RestaurantCheckOutNavigateToCreateCardState
    extends RestaurantCheckOutState {}

class RestaurantCheckOutPickAddressState extends RestaurantCheckOutActionState {
  RestaurantCheckOutPickAddressState(
      {required super.initialCameraPosition, required super.place});
}

class RestaurantCheckOutNavigateToOrderCompleteState
    extends RestaurantCheckOutState {}
