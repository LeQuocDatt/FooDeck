import 'package:template/source/export.dart';

part 'my_locations_event.dart';
part 'my_locations_state.dart';

class MyLocationsBloc extends Bloc<MyLocationsEvent, MyLocationsState> {
  late MapboxMapController mapController;
  String place = currentUser!.address ?? '';
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
    emit(MyLocationsLoadedState(
        address: address,
        initialCameraPosition:
            CameraPosition(target: SharedPrefs.userLocation(), zoom: 15)));
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
    place = event.addressModel.address;
    await addSourceAndLineLayer(event.index, address, true);
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsPickAddressState(
        initialCameraPosition: initialCameraPosition,
        address: address,
        place: event.addressModel.address));
  }

  FutureOr<void> myLocationsSaveAddressEvent(
      MyLocationsSaveAddressEvent event, Emitter<MyLocationsState> emit) async {
    place = event.addressModel.address;
    await AsyncFunctions.saveAddress(event.addressModel, event.context);
    CommonUtils.locationCameras(address);
    await addSourceAndLineLayer(
        CommonUtils.locationCameras(address).length - 1, address, true);
    AppRouter.navigatorKey.currentState!.pop();
    AppRouter.navigatorKey.currentState!.pop();
    emit(MyLocationsSaveAddressState(
        initialCameraPosition: initialCameraPosition,
        address: address,
        place: place));
  }

  FutureOr<void> myLocationsEditAddressEvent(
      MyLocationsEditAddressEvent event, Emitter<MyLocationsState> emit) {
    edit = !edit;
    emit(MyLocationsEditAddressState());
  }

  FutureOr<void> myLocationsDrawMapEvent(
      MyLocationsDrawMapEvent event, Emitter<MyLocationsState> emit) async {
    await CommonUtils.addSourceAndLineLayer(event.index, address, true);
    emit(MyLocationsDrawMapState(
        initialCameraPosition: initialCameraPosition, address: address));
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
    emit(MyLocationsRemoveAddressState(
        address: address, initialCameraPosition: initialCameraPosition));
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
    emit(MyLocationsUpdateAddressState(
        address: address, initialCameraPosition: initialCameraPosition));
  }

  onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  onStyleLoadedCallback() async {
    for (CameraPosition kRestaurant in CommonUtils.locationCameras(address)) {
      await mapController.addSymbol(
        SymbolOptions(
          geometry: kRestaurant.target,
          iconSize: 2,
          iconImage: Assets.marker,
        ),
      );
    }
    addSourceAndLineLayer(0, address, false);
  }

  addCurrentMarker(CameraPosition initialCameraPosition) async {
    await mapController.addSymbol(
      SymbolOptions(
        geometry: initialCameraPosition.target,
        iconSize: 0.2,
        iconImage: Assets.currentMarker,
      ),
    );
  }

  addSourceAndLineLayer(
      int index, List<AddressModel> listCamera, bool removeLayer) async {
    if (listCamera.isNotEmpty) {
      // Can animate camera to focus on the item
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CommonUtils.locationCameras(listCamera)[index]));
      // Add a polyLine between source and destination
      Map geometry = address[index].geometry!;
      final fills = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "id": 0,
            "properties": <String, dynamic>{},
            "geometry": geometry,
          },
        ],
      };

      // Remove lineLayer and source if it exists
      if (removeLayer == true) {
        await mapController.removeLayer("lines");
        await mapController.removeSource("fills");
      }

      // Add new source and lineLayer
      await mapController.addSource(
          "fills", GeojsonSourceProperties(data: fills));
      await mapController.addLineLayer(
        "fills",
        "lines",
        LineLayerProperties(
          lineColor: Colors.blue.toHexStringRGB(),
          lineCap: "round",
          lineJoin: "round",
          lineWidth: 5,
        ),
      );
      await mapController.addSymbol(SymbolOptions(
          geometry: CommonUtils.locationCameras(listCamera)[index].target,
          iconSize: 2,
          iconImage: Assets.marker));
    } else {
      await mapController.removeLayer("lines");
      await mapController.removeSource("fills");
      await mapController.clearSymbols();
    }
  }
}
