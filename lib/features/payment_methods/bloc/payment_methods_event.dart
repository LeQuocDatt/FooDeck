part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsEvent extends Equatable {
  const PaymentMethodsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaymentMethodsInitialEvent extends PaymentMethodsEvent {}

class PaymentMethodsNavigateToCreateCardEvent extends PaymentMethodsEvent {}

class PaymentMethodsAddCardEvent extends PaymentMethodsEvent {
  final BuildContext context;
  final String cardName, cardNumber, expiryDate, cvc;

  const PaymentMethodsAddCardEvent(
      {required this.context,
      required this.cardName,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvc});
}

class PaymentMethodsRemoveCardEvent extends PaymentMethodsEvent {
  final BuildContext context;
  final PaymentModel paymentModel;
  const PaymentMethodsRemoveCardEvent(
      {required this.context, required this.paymentModel});
}
