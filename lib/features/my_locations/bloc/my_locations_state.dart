part of 'my_locations_bloc.dart';

@immutable
sealed class MyLocationsState {}

class MyLocationsActionState extends MyLocationsState {
  final CameraPosition initialCameraPosition;
  final List<AddressModel> address;

  MyLocationsActionState(
      {required this.initialCameraPosition, required this.address});
}

final class MyLocationsInitial extends MyLocationsState {}

class MyLocationsLoadingState extends MyLocationsState {}

class MyLocationsLoadedState extends MyLocationsActionState {
  MyLocationsLoadedState(
      {required super.initialCameraPosition, required super.address});
}

class MyLocationsSearchState extends MyLocationsState {
  final String search;
  final List<AddressModel> responses;

  MyLocationsSearchState({required this.search, required this.responses});
}

class MyLocationsEditAddressState extends MyLocationsState {}

class MyLocationsPickAddressState extends MyLocationsActionState {
  final String place;

  MyLocationsPickAddressState(
      {required super.initialCameraPosition,
      required super.address,
      required this.place});
}

class MyLocationsSaveAddressState extends MyLocationsActionState {
  final String place;

  MyLocationsSaveAddressState(
      {required super.initialCameraPosition,
      required super.address,
      required this.place});
}

class MyLocationsDrawMapState extends MyLocationsActionState {
  MyLocationsDrawMapState(
      {required super.initialCameraPosition, required super.address});
}

class MyLocationsUpdateAddressState extends MyLocationsActionState {
  MyLocationsUpdateAddressState(
      {required super.initialCameraPosition, required super.address});
}

class MyLocationsRemoveAddressState extends MyLocationsActionState {
  MyLocationsRemoveAddressState(
      {required super.initialCameraPosition, required super.address});
}
