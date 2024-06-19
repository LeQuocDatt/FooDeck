part of 'restaurant_cart_bloc.dart';

sealed class RestaurantCartEvent {}

class RestaurantCartInitialEvent extends RestaurantCartEvent {}

class RestaurantCartRemoveItemEvent extends RestaurantCartEvent {
  final CartItems cartItem;

  RestaurantCartRemoveItemEvent({required this.cartItem});
}

class RestaurantCartNavigateToCheckOutEvent extends RestaurantCartEvent {}
