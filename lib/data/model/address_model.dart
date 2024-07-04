import 'package:mapbox_gl/mapbox_gl.dart';

class AddressModel {
  String name, address, area, dist, city, id, userId;
  double latitude, longitude;
  double? distance, duration;
  LatLng location;
  Map<dynamic, dynamic>? geometry;

  AddressModel(
      {required this.userId,
      required this.id,
      required this.name,
      required this.address,
      required this.area,
      required this.dist,
      required this.city,
      required this.latitude,
      required this.longitude,
      required this.location,
      this.distance,
      this.duration,
      this.geometry});
}

List<AddressModel> address = [];
late AddressModel addressModel;
