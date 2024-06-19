part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageEvent {}

class ProfilePageInitialEvent extends ProfilePageEvent {}

class ProfilePageUpdatePictureEvent extends ProfilePageEvent {
  final String imageUrl;

  ProfilePageUpdatePictureEvent({required this.imageUrl});
}

class ProfilePageNameInputEvent extends ProfilePageEvent {
  final String name;

  ProfilePageNameInputEvent({required this.name});
}

class ProfilePageEmailInputEvent extends ProfilePageEvent {
  final String email;

  ProfilePageEmailInputEvent({required this.email});
}

class ProfilePagePhoneInputEvent extends ProfilePageEvent {
  final String phone;

  ProfilePagePhoneInputEvent({required this.phone});
}

class ProfilePagePassInputEvent extends ProfilePageEvent {
  final String pass;

  ProfilePagePassInputEvent({required this.pass});
}

class ProfilePageUpdateInfoEvent extends ProfilePageEvent {
  final BuildContext context;
  final String imageUrl, name, email, phone, pass;

  ProfilePageUpdateInfoEvent(
      {required this.context,
      required this.name,
      required this.email,
      required this.phone,
      required this.pass,
      required this.imageUrl});
}

class ProfilePageNavigateEvent extends ProfilePageEvent {
  final BuildContext context;
  final String gate;

  ProfilePageNavigateEvent({required this.context, required this.gate});
}

class ProfilePageToggleThemeEvent extends ProfilePageEvent {
  final bool toggle;

  ProfilePageToggleThemeEvent({required this.toggle});
}
