import 'package:template/source/export.dart';

part 'restaurant_cart_event.dart';
part 'restaurant_cart_state.dart';

class RestaurantCartBloc
    extends Bloc<RestaurantCartEvent, RestaurantCartState> {
  RestaurantCartBloc() : super(RestaurantCartInitial()) {
    on<RestaurantCartInitialEvent>(restaurantCartInitialEvent);
    on<RestaurantCartRemoveItemEvent>(restaurantCartRemoveItemEvent);
    on<RestaurantCartNavigateBackEvent>(restaurantCartNavigateBackEvent);
    on<RestaurantCartNavigateToCheckOutEvent>(
        restaurantCartNavigateToCheckOutEvent);
  }

  FutureOr<void> restaurantCartInitialEvent(
      RestaurantCartInitialEvent event, Emitter<RestaurantCartState> emit) {
    emit(RestaurantCartLoadingState());
    emit(RestaurantCartLoadedState());
  }

  FutureOr<void> restaurantCartRemoveItemEvent(
      RestaurantCartRemoveItemEvent event, Emitter<RestaurantCartState> emit) {
    if (cartItems.length == 1) {
      cartItems.remove(event.cartItem);
      AppRouter.navigatorKey.currentState!.pop();
    } else {
      cartItems.remove(event.cartItem);
    }
    emit(RestaurantCartRemoveItemState());
  }

  FutureOr<void> restaurantCartNavigateBackEvent(
      RestaurantCartNavigateBackEvent event,
      Emitter<RestaurantCartState> emit) async {
    foodModel = event.foodModel;
    await AsyncFunctions.addAddonDataToLocalStorage();
    AppRouter.navigatorKey.currentState?.pushNamed(AppRouter.restaurantAddon);
    emit(RestaurantCartNavigateBackState());
  }

  FutureOr<void> restaurantCartNavigateToCheckOutEvent(
      RestaurantCartNavigateToCheckOutEvent event,
      Emitter<RestaurantCartState> emit) {
    AppRouter.navigatorKey.currentState!
        .pushNamed(AppRouter.restaurantCheckOut);
    emit(RestaurantCartNavigateToCheckOutState());
  }
}
