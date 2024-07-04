part of 'restaurant_cart_bloc.dart';

sealed class RestaurantCartState {}

class RestaurantCartActionState extends RestaurantCartState {}

final class RestaurantCartInitial extends RestaurantCartState {}

class RestaurantCartLoadingState extends RestaurantCartState {}

class RestaurantCartLoadedState extends RestaurantCartState {}

class RestaurantCartRemoveItemState extends RestaurantCartState {}

class RestaurantCartNavigateBackState extends RestaurantCartActionState {}

class RestaurantCartNavigateToCheckOutState extends RestaurantCartActionState {}
