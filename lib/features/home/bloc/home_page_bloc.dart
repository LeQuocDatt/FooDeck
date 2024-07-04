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
    await AsyncFunctions.updateData(
        'users',
        {
          'address': SharedPrefs.getString(SharedPrefs.keyUserAddress) ?? '',
          'latitude':
              SharedPrefs.getDouble(SharedPrefs.keyUserLatitude) ?? kLatitude,
          'longitude':
              SharedPrefs.getDouble(SharedPrefs.keyUserLongitude) ?? kLongitude
        },
        user.id,
        PopUp.deny);
    await AsyncFunctions.addUserDataToLocalStorage();
    await AsyncFunctions.addRestaurantDataToLocalStorage();
    await AsyncFunctions.addCardDataToLocalStorage();
    await AsyncFunctions.addLocationDataToLocalStorage();
    await AsyncFunctions.addOrderCompleteDataToLocalStorage();
    emit(HomePageSelectIndexState(index: 0));
  }

  FutureOr<void> homePageSelectIndexEvent(
      HomePageSelectIndexEvent event, Emitter<HomePageState> emit) {
    emit(HomePageSelectIndexState(index: event.index));
  }
}
