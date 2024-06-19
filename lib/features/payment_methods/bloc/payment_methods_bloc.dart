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
    final data = await supabase.from('card').select();
    emit(PaymentMethodsLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(PaymentMethodsLoadedState(
        paymentModel: data
            .map((event) => PaymentModel(
                cardName: event['card_name'],
                cardNumber: event['card_number'],
                expiryDate: event['expiry_date'],
                cvc: event['cvc']))
            .toList()));
  }

  FutureOr<void> paymentMethodsNavigateToCreateCardEvent(
      PaymentMethodsNavigateToCreateCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    final data = await supabase.from('card').select();
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.createCard);
    emit(PaymentMethodsNavigateToCreateCardState());
    emit(PaymentMethodsLoadedState(
        paymentModel: data
            .map((event) => PaymentModel(
                cardName: event['card_name'],
                cardNumber: event['card_number'],
                expiryDate: event['expiry_date'],
                cvc: event['cvc']))
            .toList()));
  }

  FutureOr<void> paymentMethodsRemoveCardEvent(
      PaymentMethodsRemoveCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    await AsyncFunctions.deleteData(
        'card',
        {
          'card_name': event.paymentModel.cardName,
          'card_number': event.paymentModel.cardNumber
        },
        PopUp.allow,
        event.context,
        'You just removed a card');
    final data = await supabase.from('card').select();
    currentCard.value = data
            .map((e) => PaymentModel(
                cardName: e['card_name'],
                cardNumber: e['card_number'],
                expiryDate: e['expiry_date'],
                cvc: e['cvc']))
            .toList()
            .length -
        1;
    emit(PaymentMethodsRemoveCardState());
    emit(PaymentMethodsLoadedState(
        paymentModel: data
            .map((event) => PaymentModel(
                cardName: event['card_name'],
                cardNumber: event['card_number'],
                expiryDate: event['expiry_date'],
                cvc: event['cvc']))
            .toList()));
  }

  FutureOr<void> paymentMethodsAddCardEvent(PaymentMethodsAddCardEvent event,
      Emitter<PaymentMethodsState> emit) async {
    FocusManager.instance.primaryFocus!.unfocus();
    await AsyncFunctions.insertData(
        'card',
        {
          'card_name': event.cardName,
          'card_number': event.cardNumber,
          'expiry_date': event.expiryDate,
          'cvc': event.cvc,
        },
        PopUp.allow,
        event.context,
        'You just added a new card');
    final data = await supabase.from('card').select();
    currentCard.value = data
            .map((e) => PaymentModel(
                cardName: e['card_name'],
                cardNumber: e['card_number'],
                expiryDate: e['expiry_date'],
                cvc: e['cvc']))
            .toList()
            .length -
        1;
    emit(PaymentMethodsAddCardState());
    emit(PaymentMethodsLoadedState(
        paymentModel: data
            .map((event) => PaymentModel(
                cardName: event['card_name'],
                cardNumber: event['card_number'],
                expiryDate: event['expiry_date'],
                cvc: event['cvc']))
            .toList()));
  }
}
