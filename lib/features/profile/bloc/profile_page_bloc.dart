import 'package:template/source/export.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  bool toggle = false;
  String imageUrl = '';
  String name = '';
  String email = '';
  String phone = '';
  String pass = '';
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<ProfilePageInitialEvent>(profilePageInitialEvent);
    on<ProfilePageNavigateEvent>(profilePageNavigateEvent);
    on<ProfilePageUpdatePictureEvent>(profilePageUpdatePictureEvent);
    on<ProfilePageNameInputEvent>(profilePageNameInputEvent);
    on<ProfilePageEmailInputEvent>(profilePageEmailInputEvent);
    on<ProfilePagePhoneInputEvent>(profilePagePhoneInputEvent);
    on<ProfilePagePassInputEvent>(profilePagePassInputEvent);
    on<ProfilePageToggleThemeEvent>(profilePageToggleThemeEvent);
    on<ProfilePageUpdateInfoEvent>(profilePageUpdateInfoEvent);
  }

  FutureOr<void> profilePageInitialEvent(
      ProfilePageInitialEvent event, Emitter<ProfilePageState> emit) async {
    imageUrl = '';
    name = '';
    email = '';
    phone = '';
    pass = '';
    emit(ProfilePageLoadedState(
        avatar: currentUser?.avatar,
        name: currentUser?.name,
        address: currentUser?.address));
  }

  FutureOr<void> profilePageNavigateEvent(
      ProfilePageNavigateEvent event, Emitter<ProfilePageState> emit) {
    CommonUtils.checkPageToNavigate(event.gate, event.context);
    emit(ProfilePageNavigateState());
  }

  FutureOr<void> profilePageUpdatePictureEvent(
      ProfilePageUpdatePictureEvent event,
      Emitter<ProfilePageState> emit) async {
    imageUrl = event.imageUrl;
    emit(ProfilePageUpdatePictureState(imageUrl: event.imageUrl));
  }

  FutureOr<void> profilePageNameInputEvent(
      ProfilePageNameInputEvent event, Emitter<ProfilePageState> emit) {
    name = event.name;
    emit(ProfilePageNameInputState(name: event.name));
  }

  FutureOr<void> profilePageEmailInputEvent(
      ProfilePageEmailInputEvent event, Emitter<ProfilePageState> emit) {
    email = event.email;
    emit(ProfilePageEmailInputState(email: event.email));
  }

  FutureOr<void> profilePagePhoneInputEvent(
      ProfilePagePhoneInputEvent event, Emitter<ProfilePageState> emit) {
    phone = event.phone;
    emit(ProfilePagePhoneInputState(phone: event.phone));
  }

  FutureOr<void> profilePagePassInputEvent(
      ProfilePagePassInputEvent event, Emitter<ProfilePageState> emit) {
    pass = event.pass;
    emit(ProfilePagePassInputState(pass: event.pass));
  }

  FutureOr<void> profilePageToggleThemeEvent(
      ProfilePageToggleThemeEvent event, Emitter<ProfilePageState> emit) {
    toggle = event.toggle;
    emit(ProfilePageToggleThemeState());
  }

  FutureOr<void> profilePageUpdateInfoEvent(
      ProfilePageUpdateInfoEvent event, Emitter<ProfilePageState> emit) async {
    await CommonUtils.validateInfoBeforeUpdate(event);
    emit(ProfilePageUpdateInfoState(
        avatar: currentUser?.avatar, name: currentUser?.name));
  }
}
