import 'package:template/source/export.dart';

part 'restaurant_check_out_event.dart';
part 'restaurant_check_out_state.dart';

class RestaurantCheckOutBloc
    extends Bloc<RestaurantCheckOutEvent, RestaurantCheckOutState> {
  final noteController = TextEditingController();
  RestaurantCheckOutBloc() : super(RestaurantCheckOutInitial()) {
    on<RestaurantCheckOutInitialEvent>(restaurantCheckOutInitialEvent);
    on<RestaurantCheckOutNavigateToMapEvent>(
        restaurantCheckOutNavigateToMapEvent);
    on<RestaurantCheckOutNavigateToCreateCardEvent>(
        restaurantCheckOutNavigateToCreateCardEvent);
    on<RestaurantCheckOutNavigateToOrderCompleteEvent>(
        restaurantCheckOutNavigateToOrderCompleteEvent);
  }

  FutureOr<void> restaurantCheckOutInitialEvent(
      RestaurantCheckOutInitialEvent event,
      Emitter<RestaurantCheckOutState> emit) async {
    emit(RestaurantCheckOutLoadedState(
        address: currentUser!.address ?? '',
        initialCameraPosition:
            CameraPosition(target: SharedPrefs.userLocation(), zoom: 15)));
  }

  FutureOr<void> restaurantCheckOutNavigateToMapEvent(
      RestaurantCheckOutNavigateToMapEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.myLocation);
    emit(RestaurantCheckOutNavigateToMapState());
  }

  FutureOr<void> restaurantCheckOutNavigateToCreateCardEvent(
      RestaurantCheckOutNavigateToCreateCardEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.createCard);
    emit(RestaurantCheckOutNavigateToCreateCardState());
  }

  FutureOr<void> restaurantCheckOutNavigateToOrderCompleteEvent(
      RestaurantCheckOutNavigateToOrderCompleteEvent event,
      Emitter<RestaurantCheckOutState> emit) async {
    final myLocationsBloc = event.context.read<MyLocationsBloc>();
    await AsyncFunctions.addOrderToDatabase(
        noteController.text, myLocationsBloc.place);
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.orderComplete);
    emit(RestaurantCheckOutNavigateToOrderCompleteState());
  }
}
