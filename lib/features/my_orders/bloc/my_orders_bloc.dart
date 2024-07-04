import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  MyOrdersBloc() : super(MyOrdersInitial()) {
    on<MyOrdersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
