part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutState extends Equatable {
  const RestaurantCheckOutState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantCheckOutActionState extends RestaurantCheckOutState {}

final class RestaurantCheckOutInitial extends RestaurantCheckOutState {}

class RestaurantCheckOutLoadingState extends RestaurantCheckOutState {}

class RestaurantCheckOutLoadedState extends RestaurantCheckOutState {
  final bool nothing, loading;
  final String address;
  final List responses;
  final TextEditingController searchController;

  const RestaurantCheckOutLoadedState(
      {required this.nothing,
      required this.loading,
      required this.address,
      required this.searchController,
      required this.responses});
}

class RestaurantCheckOutSearchState extends RestaurantCheckOutState {}

class RestaurantCheckOutMoveCameraState extends RestaurantCheckOutState {}

class RestaurantCheckOutEditAddressState extends RestaurantCheckOutState {}

class RestaurantCheckOutNavigateToCreateCardState
    extends RestaurantCheckOutActionState {}

class RestaurantCheckOutNavigateToOrderCompleteState
    extends RestaurantCheckOutActionState {}
