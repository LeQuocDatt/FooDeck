import 'package:template/source/export.dart';

part 'restaurant_addon_event.dart';
part 'restaurant_addon_state.dart';

class RestaurantAddonBloc
    extends Bloc<RestaurantAddonEvent, RestaurantAddonState> {
  RadioType turnOn = RadioType.a;
  String note = '';
  int get totalPrice {
    int addonPriceSize = RestaurantData.addonItems
        .where((element) => element.radio == turnOn)
        .single
        .priceSize;
    int addonPriceTopping = RestaurantData.food.availableAddons
        .where((element) => element.like == true)
        .fold(0, (previousValue, element) => previousValue + element.price);
    return (addonPriceTopping + addonPriceSize) *
        RestaurantData.food.quantityFood;
  }

  RestaurantAddonBloc() : super(RestaurantAddonInitial()) {
    on<RestaurantAddonInitialEvent>(restaurantAddonInitialEvent);
    on<RestaurantAddonPickSizeEvent>(restaurantAddonPickSizeEvent);
    on<RestaurantAddonIncreaseQuantityEvent>(
        restaurantAddonIncreaseQuantityEvent);
    on<RestaurantAddonDecreaseQuantityEvent>(
        restaurantAddonDecreaseQuantityEvent);
    on<RestaurantAddonPickToppingEvent>(restaurantAddonPickToppingEvent);
    on<RestaurantAddonNoteEvent>(restaurantAddonNoteEvent);
    on<RestaurantAddonNavigateToCartEvent>(restaurantAddonNavigateToCartEvent);
  }

  FutureOr<void> restaurantAddonInitialEvent(
      RestaurantAddonInitialEvent event, Emitter<RestaurantAddonState> emit) {
    turnOn = RadioType.a;
    note = '';
    for (var e in RestaurantData.food.availableAddons) {
      e.like = false;
    }
    RestaurantData.food.quantityFood = 1;
    emit(RestaurantAddonLoadingState());
    emit(RestaurantAddonLoadingSuccessState());
  }

  FutureOr<void> restaurantAddonPickSizeEvent(
      RestaurantAddonPickSizeEvent event, Emitter<RestaurantAddonState> emit) {
    turnOn = event.turnOn;
    emit(RestaurantAddonPickSizeState());
  }

  FutureOr<void> restaurantAddonIncreaseQuantityEvent(
      RestaurantAddonIncreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    RestaurantData.food.quantityFood++;
    emit(RestaurantAddonIncreaseQuantityState());
  }

  FutureOr<void> restaurantAddonDecreaseQuantityEvent(
      RestaurantAddonDecreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    RestaurantData.food.quantityFood--;
    emit(RestaurantAddonDecreaseQuantityState());
  }

  FutureOr<void> restaurantAddonPickToppingEvent(
      RestaurantAddonPickToppingEvent event,
      Emitter<RestaurantAddonState> emit) {
    RestaurantData.food.availableAddons[event.index].like = event.like;
    emit(RestaurantAddonPickToppingState());
  }

  FutureOr<void> restaurantAddonNoteEvent(
      RestaurantAddonNoteEvent event, Emitter<RestaurantAddonState> emit) {
    note = event.note;
    emit(RestaurantAddonNoteState());
  }

  FutureOr<void> restaurantAddonNavigateToCartEvent(
      RestaurantAddonNavigateToCartEvent event,
      Emitter<RestaurantAddonState> emit) {
    CommonUtils.addToCart(event.context, turnOn, note, totalPrice);
    emit(RestaurantAddonNavigateToCartState());
  }
}
