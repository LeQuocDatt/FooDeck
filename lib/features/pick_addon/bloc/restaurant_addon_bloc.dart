import 'package:template/source/export.dart';

part 'restaurant_addon_event.dart';
part 'restaurant_addon_state.dart';

class RestaurantAddonBloc
    extends Bloc<RestaurantAddonEvent, RestaurantAddonState> {
  String turnOn = 'a';
  String note = '';
  int quantity = 1;
  int get totalPrice {
    int addonPriceSize =
        addons.where((element) => element.type == turnOn).single.sizePrice;
    int addonPriceTopping = addons
        .where((element) => element.like == true)
        .fold(
            0, (previousValue, element) => previousValue + element.addonPrice);
    return (addonPriceTopping + addonPriceSize) * quantity;
  }

  RestaurantAddonBloc() : super(RestaurantAddonInitial()) {
    on<RestaurantAddonInitialEvent>(restaurantAddonInitialEvent);
    on<RestaurantAddonLikeEvent>(restaurantAddonLikeEvent);
    on<RestaurantAddonPickSizeEvent>(restaurantAddonPickSizeEvent);
    on<RestaurantAddonIncreaseQuantityEvent>(
        restaurantAddonIncreaseQuantityEvent);
    on<RestaurantAddonDecreaseQuantityEvent>(
        restaurantAddonDecreaseQuantityEvent);
    on<RestaurantAddonPickToppingEvent>(restaurantAddonPickToppingEvent);
    on<RestaurantAddonNoteEvent>(restaurantAddonNoteEvent);
    on<RestaurantAddonNavigateToCartEvent>(restaurantAddonNavigateToCartEvent);
  }

  FutureOr<void> restaurantAddonInitialEvent(RestaurantAddonInitialEvent event,
      Emitter<RestaurantAddonState> emit) async {
    emit(RestaurantAddonLoadingState());
    turnOn = 'a';
    note = '';
    for (var e in addons) {
      e.like = false;
    }
    quantity = 1;
    emit(RestaurantAddonLoadingSuccessState(
        addons: addons, totalPrice: totalPrice));
  }

  FutureOr<void> restaurantAddonLikeEvent(
      RestaurantAddonLikeEvent event, Emitter<RestaurantAddonState> emit) {
    emit(RestaurantAddonLikeState(foodModel: foodModel));
  }

  FutureOr<void> restaurantAddonPickSizeEvent(
      RestaurantAddonPickSizeEvent event, Emitter<RestaurantAddonState> emit) {
    turnOn = event.turnOn;
    emit(RestaurantAddonPickSizeState(addons: addons));
  }

  FutureOr<void> restaurantAddonIncreaseQuantityEvent(
      RestaurantAddonIncreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    quantity++;
    emit(RestaurantAddonIncreaseQuantityState());
  }

  FutureOr<void> restaurantAddonDecreaseQuantityEvent(
      RestaurantAddonDecreaseQuantityEvent event,
      Emitter<RestaurantAddonState> emit) {
    quantity--;
    emit(RestaurantAddonDecreaseQuantityState());
  }

  FutureOr<void> restaurantAddonPickToppingEvent(
      RestaurantAddonPickToppingEvent event,
      Emitter<RestaurantAddonState> emit) {
    addons[event.index].like = event.like;
    emit(RestaurantAddonPickToppingState(addons: addons));
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
