import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

part 'restaurant_check_out_event.dart';
part 'restaurant_check_out_state.dart';

class RestaurantCheckOutBloc
    extends Bloc<RestaurantCheckOutEvent, RestaurantCheckOutState> {
  late MapboxMapController mapController;
  CameraPosition initialCameraPosition =
      CameraPosition(target: latLng, zoom: 15);
  final searchController = TextEditingController();
  final noteController = TextEditingController();
  String address = sharedPreferences.getString('address') ??
      sharedPreferences.getString('currentAddress')!;
  List responses = [];

  RestaurantCheckOutBloc() : super(RestaurantCheckOutInitial()) {
    on<RestaurantCheckOutInitialEvent>(restaurantCheckOutInitialEvent);
    on<RestaurantCheckOutSearchEvent>(restaurantCheckOutSearchEvent);
    on<RestaurantCheckOutMoveCameraEvent>(restaurantCheckOutMoveCameraEvent);
    on<RestaurantCheckOutEditAddressEvent>(restaurantCheckOutEditAddressEvent);
    on<RestaurantCheckOutNavigateToCreateCardEvent>(
        restaurantCheckOutNavigateToCreateCardEvent);
    on<RestaurantCheckOutNavigateToOrderCompleteEvent>(
        restaurantCheckOutNavigateToOrderCompleteEvent);
  }

  FutureOr<void> restaurantCheckOutInitialEvent(
      RestaurantCheckOutInitialEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    emit(RestaurantCheckOutLoadedState(
        nothing: true,
        loading: true,
        address: '',
        responses: const [],
        searchController: searchController));
  }

  FutureOr<void> restaurantCheckOutSearchEvent(
      RestaurantCheckOutSearchEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    searchHandler(event.search);
    emit(RestaurantCheckOutSearchState());
    emit(RestaurantCheckOutLoadedState(
        nothing: true,
        loading: false,
        address: sharedPreferences.getString('address') ??
            sharedPreferences.getString('currentAddress')!,
        responses: responses,
        searchController: searchController));
  }

  FutureOr<void> restaurantCheckOutMoveCameraEvent(
      RestaurantCheckOutMoveCameraEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    moveCamera(event.index);
    emit(RestaurantCheckOutMoveCameraState());
    emit(RestaurantCheckOutLoadedState(
        nothing: true,
        loading: true,
        address: sharedPreferences.getString('address') ??
            sharedPreferences.getString('currentAddress')!,
        responses: responses,
        searchController: searchController));
  }

  FutureOr<void> restaurantCheckOutEditAddressEvent(
      RestaurantCheckOutEditAddressEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    setAddress(event.index);
    emit(RestaurantCheckOutEditAddressState());
    emit(RestaurantCheckOutLoadedState(
        nothing: true,
        loading: true,
        address: sharedPreferences.getString('address')!,
        responses: responses,
        searchController: searchController));
  }

  FutureOr<void> restaurantCheckOutNavigateToCreateCardEvent(
      RestaurantCheckOutNavigateToCreateCardEvent event,
      Emitter<RestaurantCheckOutState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.createCard);
    emit(RestaurantCheckOutNavigateToCreateCardState());
    emit(RestaurantCheckOutLoadedState(
        nothing: true,
        loading: true,
        address: sharedPreferences.getString('address')!,
        responses: const [],
        searchController: searchController));
  }

  FutureOr<void> restaurantCheckOutNavigateToOrderCompleteEvent(
      RestaurantCheckOutNavigateToOrderCompleteEvent event,
      Emitter<RestaurantCheckOutState> emit) async {
    emit(RestaurantCheckOutNavigateToOrderCompleteState());
    emit(RestaurantCheckOutLoadedState(
        nothing: false,
        loading: true,
        address: sharedPreferences.getString('address')!,
        responses: const [],
        searchController: searchController));
    addOrderToDatabase(event.context);
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(RestaurantCheckOutNavigateToOrderCompleteState());
    emit(RestaurantCheckOutLoadedState(
        nothing: false,
        loading: false,
        address: sharedPreferences.getString('address')!,
        responses: const [],
        searchController: searchController));
    CartItemsListData.cartItems.clear();
    Future.delayed(
        const Duration(milliseconds: 1500),
        () => AppRouter.navigatorKey.currentState!
            .pushNamed(AppRouter.orderComplete));
  }

  onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  addCurrentMarker() async {
    await mapController.addSymbol(
      SymbolOptions(
        geometry: initialCameraPosition.target,
        iconSize: 0.2,
        iconImage: Assets.currentMarker,
      ),
    );
  }

  searchHandler(String value) async {
    // Get response using Mapbox Search API
    List response = await getParsedResponseForQuery(value);

    responses = response;
  }

  Future moveCamera(int index) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: responses[index]['location'], zoom: 15)));
    await mapController.addSymbol(
      SymbolOptions(
        geometry: responses[index]['location'],
        iconSize: 2,
        iconImage: Assets.marker,
      ),
    );
  }

  void setAddress(int index) async {
    initialCameraPosition =
        CameraPosition(target: responses[index]['location'], zoom: 15);
    sharedPreferences.setString('address', responses[index]['address']);
    sharedPreferences.setDouble(
        'latitudeAddress', responses[index]['latitude']);
    sharedPreferences.setDouble(
        'longitudeAddress', responses[index]['longitude']);
    AppRouter.navigatorKey.currentState!.pop();
  }

  Future addOrderToDatabase(BuildContext context) async {
    final restaurantCartBloc = context.read<RestaurantCartBloc>();
    try {
      await supabase.from('order_complete').insert({
        'restaurant_name': sharedPreferences.getString('restaurantName'),
        'sub_price': restaurantCartBloc.totalPrice,
        'delivery_fee': restaurantCartBloc.deliveryFee,
        'vat': restaurantCartBloc.vat,
        'coupon': restaurantCartBloc.coupon,
        'total_price': restaurantCartBloc.bill,
        'date': DateFormat('dd MMM, yyyy').format(DateTime.now()),
        'address': address,
        'note': noteController.text.trim()
      }).then((value) async {
        late dynamic id;
        var response = await supabase.from('order_complete').select('id');
        var records = response.toList() as List;
        for (var record in records) {
          var orderCompleteId = record['id'];
          id = orderCompleteId;
        }
        for (int index = 0;
            index < CartItemsListData.cartItems.length;
            index++) {
          await supabase.from('orders').insert({
            'food_name': CartItemsListData.cartItems[index].foodItems.nameFood,
            'price': CartItemsListData.cartItems[index].price,
            'quantity': CartItemsListData.cartItems[index].quantity,
            'note': CartItemsListData.cartItems[index].note,
            'order_complete_id': id
          });
        }
      });
    } catch (e) {
      if (context.mounted) {
        customSnackBar(context, Toast.error, e.toString());
      }
    }
  }
}
