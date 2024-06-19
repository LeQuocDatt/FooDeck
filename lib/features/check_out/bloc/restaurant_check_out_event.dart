part of 'restaurant_check_out_bloc.dart';

sealed class RestaurantCheckOutEvent extends Equatable {
  const RestaurantCheckOutEvent();

  @override
  List<Object?> get props => [];
}

class RestaurantCheckOutInitialEvent extends RestaurantCheckOutEvent {
  const RestaurantCheckOutInitialEvent();
}

class RestaurantCheckOutSearchEvent extends RestaurantCheckOutEvent {
  final String search;

  const RestaurantCheckOutSearchEvent({required this.search});
}

class RestaurantCheckOutMoveCameraEvent extends RestaurantCheckOutEvent {
  final int index;

  const RestaurantCheckOutMoveCameraEvent({required this.index});
}

class RestaurantCheckOutEditAddressEvent extends RestaurantCheckOutEvent {
  final int index;

  const RestaurantCheckOutEditAddressEvent({required this.index});
}

class RestaurantCheckOutNavigateToCreateCardEvent
    extends RestaurantCheckOutEvent {}

class RestaurantCheckOutNavigateToOrderCompleteEvent
    extends RestaurantCheckOutEvent {
  final BuildContext context;

  const RestaurantCheckOutNavigateToOrderCompleteEvent({required this.context});
}
