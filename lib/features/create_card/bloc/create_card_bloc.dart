import 'package:template/source/export.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  CreateCardBloc() : super(CreateCardInitial()) {
    on<CreateCardInitialEvent>(createCardInitialEvent);
    on<CreateCardChangeTypeCardEvent>(createCardChangeTypeCardEvent);
  }
  FutureOr<void> createCardInitialEvent(
      CreateCardInitialEvent event, Emitter<CreateCardState> emit) {
    emit(CreateCardResetTypeCardState());
  }

  FutureOr<void> createCardChangeTypeCardEvent(
      CreateCardChangeTypeCardEvent event, Emitter<CreateCardState> emit) {
    emit(CreateCardResetTypeCardState());
    emit(CreateCardChangeTypeCardState(typeCard: event.typeCard));
  }
}
