import 'package:template/source/export.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  MyOrdersBloc() : super(MyOrdersInitial()) {
    on<MyOrdersInitialEvent>(myOrdersInitialEvent);
    on<MyOrdersNavigateToDetailBillPageEvent>(
        myOrdersNavigateToDetailBillPageEvent);
  }

  FutureOr<void> myOrdersInitialEvent(
      MyOrdersInitialEvent event, Emitter<MyOrdersState> emit) {
    emit(MyOrdersLoadedState());
  }

  FutureOr<void> myOrdersNavigateToDetailBillPageEvent(
      MyOrdersNavigateToDetailBillPageEvent event,
      Emitter<MyOrdersState> emit) async {
    orderCompleteModel = event.orderCompleteModel;
    await AsyncFunctions.addCartItemCompleteDataToLocalStorage();
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.detailHistoryOrder,
        arguments:
            DetailHistoryOrder(orderCompleteModel: event.orderCompleteModel));
    emit(MyOrdersNavigateToDetailBillPageState());
  }
}
