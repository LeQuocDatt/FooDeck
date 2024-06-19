part of 'create_card_bloc.dart';

@immutable
sealed class CreateCardState {}

final class CreateCardInitial extends CreateCardState {}

class CreateCardChangeTypeCardState extends CreateCardState {
  final String typeCard;

  CreateCardChangeTypeCardState({required this.typeCard});
}

class CreateCardResetTypeCardState extends CreateCardState {}
