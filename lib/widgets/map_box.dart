import 'package:template/source/export.dart';

Widget mapboxMap(
    CameraPosition initialCameraPosition, List<AddressModel> cards) {
  return MapboxMap(
    onMapIdle: () {
      CommonUtils.addCurrentMarker(initialCameraPosition);
    },
    accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
    initialCameraPosition: initialCameraPosition,
    onMapCreated: CommonUtils.onMapCreated,
    onStyleLoadedCallback: () {
      if (CommonUtils.locationCameras(cards).isNotEmpty) {
        CommonUtils.onStyleLoadedCallback();
      }
    },
    minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
  );
}
