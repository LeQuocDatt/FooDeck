part of 'create_card_bloc.dart';

@immutable
sealed class CreateCardEvent {}

class CreateCardInitialEvent extends CreateCardEvent {}

class CreateCardNameInputEvent extends CreateCardEvent {
  final String name;

  CreateCardNameInputEvent({required this.name});
}

class CreateCardNumberInputEvent extends CreateCardEvent {
  final String number;

  CreateCardNumberInputEvent({required this.number});
}

class CreateCardExpiryInputEvent extends CreateCardEvent {
  final String expiryDate;

  CreateCardExpiryInputEvent({required this.expiryDate});
}

class CreateCardCvcInputEvent extends CreateCardEvent {
  final String cvc;

  CreateCardCvcInputEvent({required this.cvc});
}
