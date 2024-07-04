part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageState {}

class ProfilePageActionState extends ProfilePageState {}

final class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  final String? avatar, name, address;

  ProfilePageLoadedState(
      {required this.avatar, required this.name, required this.address});
}

class ProfilePageUpdatePictureState extends ProfilePageState {
  final String imageUrl;

  ProfilePageUpdatePictureState({required this.imageUrl});
}

class ProfilePageNameInputState extends ProfilePageState {
  final String name;

  ProfilePageNameInputState({required this.name});
}

class ProfilePageEmailInputState extends ProfilePageState {
  final String email;

  ProfilePageEmailInputState({required this.email});
}

class ProfilePagePhoneInputState extends ProfilePageState {
  final String phone;

  ProfilePagePhoneInputState({required this.phone});
}

class ProfilePagePassInputState extends ProfilePageState {
  final String pass;

  ProfilePagePassInputState({required this.pass});
}

class ProfilePageUpdateInfoState extends ProfilePageActionState {
  final String? avatar, name;

  ProfilePageUpdateInfoState({required this.avatar, required this.name});
}

class ProfilePageNavigateState extends ProfilePageActionState {}

class ProfilePageToggleThemeState extends ProfilePageState {}
