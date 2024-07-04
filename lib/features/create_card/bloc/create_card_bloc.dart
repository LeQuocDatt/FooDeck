import 'package:template/source/export.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  String name = '';
  String number = '';
  String expiryDate = '';
  String cvc = '';
  CreateCardBloc() : super(CreateCardInitial()) {
    on<CreateCardInitialEvent>(createCardInitialEvent);
    on<CreateCardNameInputEvent>(createCardNameInputEvent);
    on<CreateCardNumberInputEvent>(createCardNumberInputEvent);
    on<CreateCardExpiryInputEvent>(createCardExpiryInputEvent);
    on<CreateCardCvcInputEvent>(createCardCvcInputEvent);
  }
  FutureOr<void> createCardInitialEvent(
      CreateCardInitialEvent event, Emitter<CreateCardState> emit) {
    name = '';
    number = '';
    expiryDate = '';
    cvc = '';
    emit(CreateCardLoadedState());
  }

  FutureOr<void> createCardNameInputEvent(
      CreateCardNameInputEvent event, Emitter<CreateCardState> emit) {
    name = event.name;
    emit(CreateCardNameInputState(name: event.name));
  }

  FutureOr<void> createCardNumberInputEvent(
      CreateCardNumberInputEvent event, Emitter<CreateCardState> emit) {
    number = event.number;
    emit(CreateCardNumberInputState(number: event.number));
  }

  FutureOr<void> createCardExpiryInputEvent(
      CreateCardExpiryInputEvent event, Emitter<CreateCardState> emit) {
    expiryDate = event.expiryDate;
    emit(CreateCardExpiryInputState(expiryDate: event.expiryDate));
  }

  FutureOr<void> createCardCvcInputEvent(
      CreateCardCvcInputEvent event, Emitter<CreateCardState> emit) {
    cvc = event.cvc;
    emit(CreateCardCvcInputState(cvc: event.cvc));
  }
}
