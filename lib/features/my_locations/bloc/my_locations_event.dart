part of 'my_locations_bloc.dart';

@immutable
sealed class MyLocationsEvent {}

class MyLocationsInitialEvent extends MyLocationsEvent {}

class MyLocationsSearchEvent extends MyLocationsEvent {
  final String search;

  MyLocationsSearchEvent({required this.search});
}

class MyLocationsEditAddressEvent extends MyLocationsEvent {}

class MyLocationsPickAddressEvent extends MyLocationsEvent {
  final int index;
  final AddressModel addressModel;

  MyLocationsPickAddressEvent(
      {required this.index, required this.addressModel});
}

class MyLocationsSaveAddressEvent extends MyLocationsEvent {
  final BuildContext context;
  final AddressModel addressModel;

  MyLocationsSaveAddressEvent(
      {required this.context, required this.addressModel});
}

class MyLocationsDrawMapEvent extends MyLocationsEvent {
  final int index;

  MyLocationsDrawMapEvent({required this.index});
}

class MyLocationsUpdateAddressEvent extends MyLocationsEvent {
  final int index;
  final BuildContext context;
  final AddressModel addressModel;
  final AddressModel addressId;

  MyLocationsUpdateAddressEvent(
      {required this.index,
      required this.context,
      required this.addressModel,
      required this.addressId});
}

class MyLocationsRemoveAddressEvent extends MyLocationsEvent {
  final int index;
  final BuildContext context;
  final AddressModel addressModel;

  MyLocationsRemoveAddressEvent(
      {required this.index, required this.context, required this.addressModel});
}
