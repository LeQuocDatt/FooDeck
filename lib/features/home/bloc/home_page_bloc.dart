import 'package:template/source/export.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageInitialEvent>(homePageInitialEvent);
    on<HomePageSelectIndexEvent>(homePageSelectIndexEvent);
  }

  FutureOr<void> homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(HomePageSelectIndexState(index: 0));
  }

  FutureOr<void> homePageSelectIndexEvent(
      HomePageSelectIndexEvent event, Emitter<HomePageState> emit) {
    emit(HomePageSelectIndexState(index: event.index));
  }
}
