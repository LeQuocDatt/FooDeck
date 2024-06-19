part of 'explore_page_bloc.dart';

sealed class ExplorePageState {}

class ExplorePageActionState extends ExplorePageState {}

final class ExplorePageInitial extends ExplorePageState {}

class ExplorePageLoadingState extends ExplorePageState {}

class ExplorePageErrorState extends ExplorePageState {}

class ExplorePageLoadingSuccessState extends ExplorePageState {
  final Map<String, dynamic> userModel;

  ExplorePageLoadingSuccessState({required this.userModel});
}

class ExplorePageLikeState extends ExplorePageActionState {
  final RestaurantModel restaurantModel;

  ExplorePageLikeState({required this.restaurantModel});
}

class ExplorePageSearchNavigateActionState extends ExplorePageActionState {}

class ExplorePageCartNavigateActionState extends ExplorePageActionState {}

class ExplorePageNavigateActionState extends ExplorePageActionState {}
