part of 'my_orders_bloc.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoadedState extends MyOrdersState {}

class MyOrdersNavigateToDetailBillPageState extends MyOrdersState {}
