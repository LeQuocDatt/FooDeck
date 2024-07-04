import 'package:template/source/export.dart';

part 'explore_page_event.dart';
part 'explore_page_state.dart';

class ExplorePageBloc extends Bloc<ExplorePageEvent, ExplorePageState> {
  ExplorePageBloc() : super(ExplorePageInitial()) {
    on<ExplorePageInitialEvent>(explorePageInitialEvent);
    on<ExplorePageSearchNavigateEvent>(explorePageSearchNavigateEvent);
    on<ExplorePageNavigateEvent>(explorePageNavigateEvent);
    on<ExplorePageCartNavigateEvent>(explorePageCartNavigateEvent);
    on<ExplorePageLikeEvent>(explorePageLikeEvent);
  }

  FutureOr<void> explorePageInitialEvent(
      ExplorePageInitialEvent event, Emitter<ExplorePageState> emit) async {
    emit(ExplorePageLoadingSuccessState(
        restaurants: restaurants, userAddress: currentUser?.address));
  }

  FutureOr<void> explorePageSearchNavigateEvent(
      ExplorePageSearchNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.searchPage);
    emit(ExplorePageSearchNavigateActionState());
  }

  FutureOr<void> explorePageNavigateEvent(
      ExplorePageNavigateEvent event, Emitter<ExplorePageState> emit) async {
    restaurantModel = event.restaurantModel;
    await AsyncFunctions.addFoodDataToLocalStorage();
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantPage);
    emit(ExplorePageNavigateActionState());
  }

  FutureOr<void> explorePageCartNavigateEvent(
      ExplorePageCartNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantCart);
    emit(ExplorePageCartNavigateActionState());
  }

  FutureOr<void> explorePageLikeEvent(
      ExplorePageLikeEvent event, Emitter<ExplorePageState> emit) async {
    CommonUtils.toggleSave(event);
    emit(ExplorePageLikeState(restaurantModel: event.saveFood));
  }
}
