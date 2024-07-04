import 'package:template/source/export.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  List<RestaurantModel> filterItems = [];
  SearchPageBloc() : super(SearchPageInitial()) {
    on<SearchPageInitialEvent>(searchPageInitialEvent);
    on<SearchEvent>(searchEvent);
    on<SearchPageNavigateToRestaurantPageEvent>(
        searchPageNavigateToRestaurantPageEvent);
  }

  FutureOr<void> searchPageInitialEvent(
      SearchPageInitialEvent event, Emitter<SearchPageState> emit) {
    emit(SearchState(filterItems: const []));
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter<SearchPageState> emit) {
    if (event.search.isEmpty) {
      filterItems = [];
    } else {
      filterItems = restaurants
          .where((element) => element.shopName
              .toLowerCase()
              .contains(event.search.toLowerCase()))
          .toList();
    }
    emit(SearchState(filterItems: filterItems));
  }

  FutureOr<void> searchPageNavigateToRestaurantPageEvent(
      SearchPageNavigateToRestaurantPageEvent event,
      Emitter<SearchPageState> emit) {
    restaurantModel = event.restaurantModel;
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantPage);
    emit(SearchPageNavigateToRestaurantPageState());
  }
}
