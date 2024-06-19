import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

part 'restaurant_addon_event.dart';
part 'restaurant_addon_state.dart';

class RestaurantAddonBloc
    extends Bloc<RestaurantAddonEvent, RestaurantAddonState> {
  RadioType turnOn = RadioType.a;
  String note = '';
  List<bool> like = [false, false];
  List<int> slot = [0, 0];
  int get totalPrice {
    int addonPriceSize = RestaurantData.addonItems
        .where((element) => element.radio == turnOn)
        .single
        .priceSize;
    return (slot[0] + slot[1] + addonPriceSize) *
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
    like = [false, false];
    slot = [0, 0];
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
    like[event.index] = event.like;
    like[event.index]
        ? slot[event.index] = RestaurantData.addonItems[event.index].price
        : slot[event.index] = 0;
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
    addToCart(event.context);
    emit(RestaurantAddonNavigateToCartState());
  }

  void addToCart(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    String size = RestaurantData.addonItems
        .where((element) => element.radio == turnOn)
        .single
        .size;
    List<String> currentSelect = [];
    like[0] == true
        ? currentSelect.add(RestaurantData.addonItems[0].addonName)
        : currentSelect.add('');
    like[1] == true
        ? currentSelect.add(RestaurantData.addonItems[1].addonName)
        : currentSelect.add('');
    CartItems? cart = CartItemsListData.cartItems.firstWhereOrNull((element) {
      bool isSameFood = element.foodItems == RestaurantData.food;
      bool isSameNote = element.note == note;
      bool isSameSize = element.size == size;
      bool isSameAddon =
          const ListEquality().equals(element.selectAddon, currentSelect);
      return isSameFood && isSameNote && isSameSize && isSameAddon;
    });
    if (cart != null) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const CustomText(
                    content: 'Are you want to increase quantity?',
                    textOverflow: TextOverflow.visible),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        cart.quantity += RestaurantData.food.quantityFood;
                        cart.price += totalPrice;
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRouter.restaurantCart);
                      },
                      child: const CustomText(content: 'Yes')),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(content: 'No')),
                ],
              ));
    } else {
      CartItemsListData.cartItems.add(CartItems(
          note: note,
          foodItems: RestaurantData.food,
          size: size,
          price: totalPrice,
          selectAddon: currentSelect,
          quantity: RestaurantData.food.quantityFood));
      Navigator.pushNamed(context, AppRouter.restaurantCart);
    }
  }
}
