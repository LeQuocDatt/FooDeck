part of 'restaurant_addon_bloc.dart';

sealed class RestaurantAddonState {}

class RestaurantAddonCountState extends RestaurantAddonState {}

class RestaurantAddonActionState extends RestaurantAddonState {}

final class RestaurantAddonInitial extends RestaurantAddonState {}

class RestaurantAddonLoadingState extends RestaurantAddonState {}

class RestaurantAddonLoadingSuccessState extends RestaurantAddonState {}

class RestaurantAddonLikeState extends RestaurantAddonState {}

class RestaurantAddonPickSizeState extends RestaurantAddonState {}

class RestaurantAddonIncreaseQuantityState extends RestaurantAddonCountState {}

class RestaurantAddonDecreaseQuantityState extends RestaurantAddonCountState {}

class RestaurantAddonPickToppingState extends RestaurantAddonState {}

class RestaurantAddonNoteState extends RestaurantAddonState {}

class RestaurantAddonNavigateToCartState extends RestaurantAddonActionState {}
