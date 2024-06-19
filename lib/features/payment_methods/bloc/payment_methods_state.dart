part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaymentMethodsActionState extends PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsLoadingState extends PaymentMethodsState {}

class PaymentMethodsLoadedState extends PaymentMethodsState {
  final List<PaymentModel> paymentModel;

  const PaymentMethodsLoadedState({required this.paymentModel});
}

class PaymentMethodsNavigateToCreateCardState
    extends PaymentMethodsActionState {}

class PaymentMethodsAddCardState extends PaymentMethodsState {}

class PaymentMethodsRemoveCardState extends PaymentMethodsState {}
