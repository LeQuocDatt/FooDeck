import 'package:template/source/export.dart';

part 'restaurant_check_out_event.dart';
part 'restaurant_check_out_state.dart';

class RestaurantCheckOutBloc
    extends Bloc<RestaurantCheckOutEvent, RestaurantCheckOutState> {
  String place = currentUser!.address ?? '';
  final noteController = TextEditingController();
  CameraPosition initialCameraPosition =
      CameraPosition(target: SharedPrefs.userLocation(), zoom: 15);
  RestaurantCheckOutBloc() : super(RestaurantCheckOutInitial()) {
    on<RestaurantCheckOutInitialEvent>(restaurantCheckOutInitialEvent);
    on<RestaurantCheckOutRelocateAddressEvent>(
        restaurantCheckOutRelocateAddressEvent);
    on<RestaurantCheckOutSearchEvent>(restaurantCheckOutSearchEvent);
    on<RestaurantCheckOutSaveAddressEvent>(restaurantCheckOutSaveAddressEvent);
    on<RestaurantCheckOutPickAddressEvent>(restaurantCheckOutPickAddressEvent);
    on<RestaurantCheckOutNavigateToCreateCardEvent>(
        restaurantCheckOutNavigateToCreateCardEvent);
    on<RestaurantCheckOutNavigateToOrderCompleteEvent>(
        restaurantCheckOutNavigateToOrderCompleteEvent);
  }

  FutureOr<void> restaurantCheckOutInitialEvent(
      RestaurantCheckOutInitialEvent event,
      Emitter<RestaurantCheckOutState> emit) async {
    emit(RestaurantCheckOutLoadedState(
        place: place, initialCameraPosition: initialCameraPosition));
  }

  FutureOr<void> restaurantCheckOutRelocateAddressEvent(
      RestaurantCheckOutRelocateAddressEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    CommonUtils.moveCamera(SharedPrefs.userLocation());
    place = currentUser!.address ?? '';
    initialCameraPosition =
        CameraPosition(target: SharedPrefs.userLocation(), zoom: 15);
    AppRouter.navigatorKey.currentState!.pop();
    emit(RestaurantCheckOutRelocateAddressState(
        initialCameraPosition: initialCameraPosition, place: place));
  }

  FutureOr<void> restaurantCheckOutSearchEvent(
      RestaurantCheckOutSearchEvent event,
      Emitter<RestaurantCheckOutState> emit) async {
    final response = await getSearchResultsFromQueryUsingMapbox(event.search);
    final List res = response['features'];
    emit(RestaurantCheckOutSearchState(
        search: event.search,
        responses: res
            .map((e) => AddressModel(
                name: e['text'],
                address: e['place_name'],
                location: LatLng(e['center'][1], e['center'][0]),
                latitude: e['center'][1],
                longitude: e['center'][0],
                area: e['context'] == null ? '' : e['context'][0]['text'],
                dist: e['context'] == null || e['context'].length < 3
                    ? ''
                    : e['context'][2]['text'],
                city: e['context'] == null || e['context'].length < 4
                    ? ''
                    : e['context'][3]['text'],
                id: e['id'],
                userId: user.id))
            .toList()));
  }

  FutureOr<void> restaurantCheckOutSaveAddressEvent(
      RestaurantCheckOutSaveAddressEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    place = event.place;
    initialCameraPosition = event.initialCameraPosition;
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(RestaurantCheckOutSaveAddressState(
        place: event.place,
        initialCameraPosition: event.initialCameraPosition));
  }

  FutureOr<void> restaurantCheckOutPickAddressEvent(
      RestaurantCheckOutPickAddressEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    place = event.place;
    initialCameraPosition = event.initialCameraPosition;
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(RestaurantCheckOutPickAddressState(
        place: event.place,
        initialCameraPosition: event.initialCameraPosition));
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
    await AsyncFunctions.addOrderToDatabase(noteController.text, place);
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.orderComplete);
    emit(RestaurantCheckOutNavigateToOrderCompleteState());
  }
}
