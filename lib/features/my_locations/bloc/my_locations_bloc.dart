import 'package:template/source/export.dart';

part 'my_locations_event.dart';
part 'my_locations_state.dart';

class MyLocationsBloc extends Bloc<MyLocationsEvent, MyLocationsState> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);
  final CameraPosition initialCameraPosition =
      CameraPosition(target: SharedPrefs.userLocation(), zoom: 15);
  bool edit = false;
  MyLocationsBloc() : super(MyLocationsInitial()) {
    on<MyLocationsInitialEvent>(myLocationsInitialEvent);
    on<MyLocationsSearchEvent>(myLocationsSearchEvent);
    on<MyLocationsPickAddressEvent>(myLocationsPickAddressEvent);
    on<MyLocationsSaveAddressEvent>(myLocationsSaveAddressEvent);
    on<MyLocationsEditAddressEvent>(myLocationsEditAddressEvent);
    on<MyLocationsDrawMapEvent>(myLocationsDrawMapEvent);
    on<MyLocationsRemoveAddressEvent>(myLocationsRemoveAddressEvent);
    on<MyLocationsUpdateAddressEvent>(myLocationsUpdateAddressEvent);
  }

  FutureOr<void> myLocationsInitialEvent(
      MyLocationsInitialEvent event, Emitter<MyLocationsState> emit) {
    emit(MyLocationsLoadedState(address: address));
  }

  FutureOr<void> myLocationsSearchEvent(
      MyLocationsSearchEvent event, Emitter<MyLocationsState> emit) async {
    final response = await getSearchResultsFromQueryUsingMapbox(event.search);
    final List res = response['features'];
    emit(MyLocationsSearchState(
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

  FutureOr<void> myLocationsPickAddressEvent(
      MyLocationsPickAddressEvent event, Emitter<MyLocationsState> emit) async {
    CommonUtils.moveCamera(address[event.index].location);
    pageController.jumpToPage(event.index);
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsPickAddressState(address: address));
  }

  FutureOr<void> myLocationsSaveAddressEvent(
      MyLocationsSaveAddressEvent event, Emitter<MyLocationsState> emit) async {
    await AsyncFunctions.saveAddress(event.addressModel, event.context);
    await AsyncFunctions.addLocationDataToLocalStorage();
    pageController.jumpToPage(address.length - 1);
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsSaveAddressState(address: address));
  }

  FutureOr<void> myLocationsEditAddressEvent(
      MyLocationsEditAddressEvent event, Emitter<MyLocationsState> emit) {
    edit = !edit;
    emit(MyLocationsEditAddressState());
  }

  FutureOr<void> myLocationsDrawMapEvent(
      MyLocationsDrawMapEvent event, Emitter<MyLocationsState> emit) async {
    await CommonUtils.addSourceAndLineLayer(event.index, address, true);
    emit(MyLocationsDrawMapState(address: address));
  }

  FutureOr<void> myLocationsRemoveAddressEvent(
      MyLocationsRemoveAddressEvent event,
      Emitter<MyLocationsState> emit) async {
    await AsyncFunctions.deleteData('locations', event.addressModel.id,
        PopUp.allow, event.context, 'Address was deleted');
    address.removeAt(event.index);
    CommonUtils.locationCameras(address);
    await CommonUtils.addSourceAndLineLayer(event.index, address, true);
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsRemoveAddressState(address: address));
  }

  FutureOr<void> myLocationsUpdateAddressEvent(
      MyLocationsUpdateAddressEvent event,
      Emitter<MyLocationsState> emit) async {
    edit = !edit;
    await AsyncFunctions.updateAddress(
        event.addressModel, event.addressId, event.context);
    await AsyncFunctions.addLocationDataToLocalStorage();
    await CommonUtils.addSourceAndLineLayer(event.index, address, true);
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsUpdateAddressState(address: address));
  }
}
