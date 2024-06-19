part of 'restaurant_page_bloc.dart';

sealed class RestaurantPageState {}

class RestaurantPageActionState extends RestaurantPageState {}

final class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageLoadingState extends RestaurantPageState {}

class RestaurantPageLoadingSuccessState extends RestaurantPageState {}

class RestaurantPageShareState extends RestaurantPageActionState {}

class RestaurantPageReportState extends RestaurantPageActionState {}

class RestaurantPageSetReviewState extends RestaurantPageActionState {}

class RestaurantPageSetRateState extends RestaurantPageActionState {}

class RestaurantPageSentReviewState extends RestaurantPageActionState {}

class RestaurantPageMapState extends RestaurantPageActionState {}

class RestaurantPageNavigateToAddonState extends RestaurantPageActionState {}
