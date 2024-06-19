import 'package:template/source/export.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  double rate = 1;
  String review = '';
  RestaurantPageBloc() : super(RestaurantPageInitial()) {
    on<RestaurantPageInitialEvent>(restaurantPageInitialEvent);
    on<RestaurantPageShareEvent>(restaurantPageShareEvent);
    on<RestaurantPageReportEvent>(restaurantPageReportEvent);
    on<RestaurantPageSetReviewEvent>(restaurantPageSetReviewEvent);
    on<RestaurantPageSetRateEvent>(restaurantPageSetRateEvent);
    on<RestaurantPageSentReviewEvent>(restaurantPageSentReviewEvent);
    on<RestaurantPageMapEvent>(restaurantPageMapEvent);
    on<RestaurantPageNavigateToAddonEvent>(restaurantPageNavigateToAddonEvent);
  }

  FutureOr<void> restaurantPageInitialEvent(
      RestaurantPageInitialEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageLoadingState());
    emit(RestaurantPageLoadingSuccessState());
  }

  FutureOr<void> restaurantPageShareEvent(
      RestaurantPageShareEvent event, Emitter<RestaurantPageState> emit) async {
    await Share.share('text');
    emit(RestaurantPageShareState());
  }

  FutureOr<void> restaurantPageReportEvent(
      RestaurantPageReportEvent event, Emitter<RestaurantPageState> emit) {
    emit(RestaurantPageReportState());
  }

  FutureOr<void> restaurantPageSetReviewEvent(
      RestaurantPageSetReviewEvent event, Emitter<RestaurantPageState> emit) {
    review = event.review;
    emit(RestaurantPageSetReviewState());
  }

  FutureOr<void> restaurantPageSetRateEvent(
      RestaurantPageSetRateEvent event, Emitter<RestaurantPageState> emit) {
    rate = event.rate;
    emit(RestaurantPageSetRateState());
  }

  FutureOr<void> restaurantPageSentReviewEvent(
      RestaurantPageSentReviewEvent event, Emitter<RestaurantPageState> emit) {
    CommonUtils.sendReview(event.context, review, event.restaurant, rate);
    emit(RestaurantPageSentReviewState());
  }

  FutureOr<void> restaurantPageMapEvent(
      RestaurantPageMapEvent event, Emitter<RestaurantPageState> emit) {
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.myLocation);
    emit(RestaurantPageMapState());
  }

  FutureOr<void> restaurantPageNavigateToAddonEvent(
      RestaurantPageNavigateToAddonEvent event,
      Emitter<RestaurantPageState> emit) {
    RestaurantData.food = event.foodItems;
    AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.restaurantAddon);
    emit(RestaurantPageNavigateToAddonState());
  }
}
