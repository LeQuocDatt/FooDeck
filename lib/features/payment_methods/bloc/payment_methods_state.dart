part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsState {}

class PaymentMethodsActionState extends PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

class PaymentMethodsLoadingState extends PaymentMethodsState {}

class PaymentMethodsLoadedState extends PaymentMethodsActionState {}

class PaymentMethodsNavigateToCreateCardState extends PaymentMethodsState {}

class PaymentMethodsAddCardState extends PaymentMethodsActionState {}

class PaymentMethodsRemoveCardState extends PaymentMethodsActionState {}
