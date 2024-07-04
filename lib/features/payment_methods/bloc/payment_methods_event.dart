part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsEvent {}

class PaymentMethodsInitialEvent extends PaymentMethodsEvent {}

class PaymentMethodsNavigateToCreateCardEvent extends PaymentMethodsEvent {}

class PaymentMethodsAddCardEvent extends PaymentMethodsEvent {
  final BuildContext context;
  final String cardName, cardNumber, expiryDate, cvc;

  PaymentMethodsAddCardEvent(
      {required this.context,
      required this.cardName,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvc});
}

class PaymentMethodsRemoveCardEvent extends PaymentMethodsEvent {
  final BuildContext context;
  final PaymentModel paymentModel;
  PaymentMethodsRemoveCardEvent(
      {required this.context, required this.paymentModel});
}
