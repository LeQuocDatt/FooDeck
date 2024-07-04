part of 'restaurant_cart_bloc.dart';

sealed class RestaurantCartEvent {}

class RestaurantCartInitialEvent extends RestaurantCartEvent {}

class RestaurantCartRemoveItemEvent extends RestaurantCartEvent {
  final CartItemModel cartItem;

  RestaurantCartRemoveItemEvent({required this.cartItem});
}

class RestaurantCartNavigateBackEvent extends RestaurantCartEvent {
  final FoodModel foodModel;

  RestaurantCartNavigateBackEvent({required this.foodModel});
}

class RestaurantCartNavigateToCheckOutEvent extends RestaurantCartEvent {}
