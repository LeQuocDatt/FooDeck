part of 'my_locations_bloc.dart';

@immutable
sealed class MyLocationsState {}

class MyLocationsActionState extends MyLocationsState {
  final List<AddressModel> address;

  MyLocationsActionState({required this.address});
}

final class MyLocationsInitial extends MyLocationsState {}

class MyLocationsLoadingState extends MyLocationsState {}

class MyLocationsLoadedState extends MyLocationsActionState {
  MyLocationsLoadedState({required super.address});
}

class MyLocationsSearchState extends MyLocationsState {
  final String search;
  final List<AddressModel> responses;

  MyLocationsSearchState({required this.search, required this.responses});
}

class MyLocationsEditAddressState extends MyLocationsState {}

class MyLocationsPickAddressState extends MyLocationsActionState {
  MyLocationsPickAddressState({required super.address});
}

class MyLocationsSaveAddressState extends MyLocationsActionState {
  MyLocationsSaveAddressState({required super.address});
}

class MyLocationsDrawMapState extends MyLocationsActionState {
  MyLocationsDrawMapState({required super.address});
}

class MyLocationsUpdateAddressState extends MyLocationsActionState {
  MyLocationsUpdateAddressState({required super.address});
}

class MyLocationsRemoveAddressState extends MyLocationsActionState {
  MyLocationsRemoveAddressState({required super.address});
}
