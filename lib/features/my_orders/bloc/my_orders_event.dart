part of 'my_orders_bloc.dart';

@immutable
sealed class MyOrdersEvent {}

class MyOrdersInitialEvent extends MyOrdersEvent {}

class MyOrdersNavigateToDetailBillPageEvent extends MyOrdersEvent {
  final OrderCompleteModel orderCompleteModel;

  MyOrdersNavigateToDetailBillPageEvent({required this.orderCompleteModel});
}
