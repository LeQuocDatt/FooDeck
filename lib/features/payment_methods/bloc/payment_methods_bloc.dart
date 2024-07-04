import 'package:template/source/export.dart';

part 'payment_methods_event.dart';
part 'payment_methods_state.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final currentCard = ValueNotifier(0);
  PaymentMethodsBloc() : super(PaymentMethodsInitial()) {
    on<PaymentMethodsInitialEvent>(paymentMethodsInitialEvent);
    on<PaymentMethodsNavigateToCreateCardEvent>(
        paymentMethodsNavigateToCreateCardEvent);
    on<PaymentMethodsAddCardEvent>(paymentMethodsAddCardEvent);
    on<PaymentMethodsRemoveCardEvent>(paymentMethodsRemoveCardEvent);
  }

  FutureOr<void> paymentMethodsInitialEvent(PaymentMethodsInitialEvent event,
      Emitter<PaymentMethodsState> emit) async {
    emit(PaymentMethodsLoadedState());
  }

  FutureOr<void> paymentMethodsNavigateToCreateCardEvent(
      PaymentMethodsNavigateToCreateCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.createCard);
    emit(PaymentMethodsNavigateToCreateCardState());
  }

  FutureOr<void> paymentMethodsAddCardEvent(PaymentMethodsAddCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (payments.length >= 2) {
      customSnackBar(event.context, Toast.error, 'You can only have 2 cards');
    } else {
      if (!Validation.cardNameRegex.hasMatch(event.cardName) ||
          event.cardNumber.length < 19 ||
          event.expiryDate.isEmpty ||
          event.cvc.length < 3) {
        customSnackBar(
            event.context, Toast.error, 'All info must correct and not empty');
      } else {
        if (payments.any((element) => element.cardNumber == event.cardNumber)) {
          customSnackBar(
              event.context, Toast.error, 'You already had this card');
        } else {
          await AsyncFunctions.insertData(
              'card',
              {
                'card_name': event.cardName,
                'card_number': event.cardNumber,
                'expiry_date': event.expiryDate,
                'cvc': event.cvc,
                'user_id': user.id
              },
              PopUp.allow,
              event.context,
              'You just added a new card');
          await AsyncFunctions.addCardDataToLocalStorage();
          currentCard.value = payments.length - 1;
          emit(PaymentMethodsAddCardState());
        }
      }
    }
  }

  FutureOr<void> paymentMethodsRemoveCardEvent(
      PaymentMethodsRemoveCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    await AsyncFunctions.deleteData('card', event.paymentModel.id, PopUp.allow,
        event.context, 'You just removed a card');
    payments.remove(event.paymentModel);
    currentCard.value = payments.length - 1;
    emit(PaymentMethodsRemoveCardState());
  }
}
