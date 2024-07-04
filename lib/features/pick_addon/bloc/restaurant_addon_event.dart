part of 'restaurant_addon_bloc.dart';

sealed class RestaurantAddonEvent {}

class RestaurantAddonInitialEvent extends RestaurantAddonEvent {}

class RestaurantAddonLikeEvent extends RestaurantAddonEvent {
  final FoodModel foodModel;

  RestaurantAddonLikeEvent({required this.foodModel});
}

class RestaurantAddonPickSizeEvent extends RestaurantAddonEvent {
  final String turnOn;
  final int index;

  RestaurantAddonPickSizeEvent({required this.turnOn, required this.index});
}

class RestaurantAddonIncreaseQuantityEvent extends RestaurantAddonEvent {}

class RestaurantAddonRepeatIncreaseQuantityEvent extends RestaurantAddonEvent {}

class RestaurantAddonDecreaseQuantityEvent extends RestaurantAddonEvent {}

class RestaurantAddonRepeatDecreaseQuantityEvent extends RestaurantAddonEvent {}

class RestaurantAddonPickToppingEvent extends RestaurantAddonEvent {
  final bool like;
  final int index;

  RestaurantAddonPickToppingEvent({required this.like, required this.index});
}

class RestaurantAddonNoteEvent extends RestaurantAddonEvent {
  final String note;

  RestaurantAddonNoteEvent({required this.note});
}

class RestaurantAddonNavigateToCartEvent extends RestaurantAddonEvent {
  final BuildContext context;

  RestaurantAddonNavigateToCartEvent({required this.context});
}
