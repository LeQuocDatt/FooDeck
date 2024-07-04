part of 'create_card_bloc.dart';

@immutable
sealed class CreateCardState {}

final class CreateCardInitial extends CreateCardState {}

class CreateCardLoadedState extends CreateCardState {}

class CreateCardNameInputState extends CreateCardState {
  final String name;

  CreateCardNameInputState({required this.name});
}

class CreateCardNumberInputState extends CreateCardState {
  final String number;

  CreateCardNumberInputState({required this.number});
}

class CreateCardExpiryInputState extends CreateCardState {
  final String expiryDate;

  CreateCardExpiryInputState({required this.expiryDate});
}

class CreateCardCvcInputState extends CreateCardState {
  final String cvc;

  CreateCardCvcInputState({required this.cvc});
}
