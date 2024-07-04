part of 'restaurant_addon_bloc.dart';

sealed class RestaurantAddonState {}

class RestaurantAddonCountState extends RestaurantAddonState {}

class RestaurantAddonActionState extends RestaurantAddonState {}

final class RestaurantAddonInitial extends RestaurantAddonState {}

class RestaurantAddonLoadingState extends RestaurantAddonState {}

class RestaurantAddonLoadingSuccessState extends RestaurantAddonState {
  final int totalPrice;
  final List<AddonModel> addons;

  RestaurantAddonLoadingSuccessState(
      {required this.totalPrice, required this.addons});
}

class RestaurantAddonLikeState extends RestaurantAddonState {
  final FoodModel foodModel;

  RestaurantAddonLikeState({required this.foodModel});
}

class RestaurantAddonPickSizeState extends RestaurantAddonState {
  final List<AddonModel> addons;

  RestaurantAddonPickSizeState({required this.addons});
}

class RestaurantAddonIncreaseQuantityState extends RestaurantAddonCountState {}

class RestaurantAddonDecreaseQuantityState extends RestaurantAddonCountState {}

class RestaurantAddonPickToppingState extends RestaurantAddonState {
  final List<AddonModel> addons;

  RestaurantAddonPickToppingState({required this.addons});
}

class RestaurantAddonNoteState extends RestaurantAddonState {}

class RestaurantAddonNavigateToCartState extends RestaurantAddonActionState {}
