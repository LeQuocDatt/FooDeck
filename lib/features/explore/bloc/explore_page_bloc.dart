import 'package:template/source/export.dart';

part 'explore_page_event.dart';
part 'explore_page_state.dart';

class ExplorePageBloc extends Bloc<ExplorePageEvent, ExplorePageState> {
  final UserRepository userRepository;
  ExplorePageBloc(this.userRepository) : super(ExplorePageInitial()) {
    on<ExplorePageInitialEvent>(explorePageInitialEvent);
    on<ExplorePageSearchNavigateEvent>(explorePageSearchNavigateEvent);
    on<ExplorePageNavigateEvent>(explorePageNavigateEvent);
    on<ExplorePageCartNavigateEvent>(explorePageCartNavigateEvent);
    on<ExplorePageLikeEvent>(explorePageLikeEvent);
  }

  FutureOr<void> explorePageInitialEvent(
      ExplorePageInitialEvent event, Emitter<ExplorePageState> emit) async {
    emit(ExplorePageLoadingState());
    try {
      final user = await userRepository.getUser();
      emit(ExplorePageLoadingSuccessState(userModel: user));
    } catch (e) {
      emit(ExplorePageErrorState());
    }
  }

  FutureOr<void> explorePageSearchNavigateEvent(
      ExplorePageSearchNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.searchPage);
    emit(ExplorePageSearchNavigateActionState());
  }

  FutureOr<void> explorePageNavigateEvent(
      ExplorePageNavigateEvent event, Emitter<ExplorePageState> emit) {
    sharedPreferences.setString(
        'restaurantName', event.restaurantModel.shopName);
    RestaurantData.restaurantModel = event.restaurantModel;
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantPage);
    emit(ExplorePageNavigateActionState());
  }

  FutureOr<void> explorePageCartNavigateEvent(
      ExplorePageCartNavigateEvent event, Emitter<ExplorePageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantCart);
    emit(ExplorePageCartNavigateActionState());
  }

  FutureOr<void> explorePageLikeEvent(
      ExplorePageLikeEvent event, Emitter<ExplorePageState> emit) {
    emit(ExplorePageLikeState(restaurantModel: event.saveFood));
    CommonUtils.toggleSave(event);
  }
}
