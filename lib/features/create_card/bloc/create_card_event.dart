part of 'create_card_bloc.dart';

@immutable
sealed class CreateCardEvent {}

class CreateCardInitialEvent extends CreateCardEvent {}

class CreateCardChangeTypeCardEvent extends CreateCardEvent {
  final String typeCard;

  CreateCardChangeTypeCardEvent({required this.typeCard});
}
