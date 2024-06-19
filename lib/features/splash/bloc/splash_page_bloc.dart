import 'package:template/source/export.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  SplashPageBloc() : super(SplashPageInitial()) {
    on<SplashPageInitialEvent>(splashPageInitialEvent);
  }

  FutureOr<void> splashPageInitialEvent(
      SplashPageInitialEvent event, Emitter<SplashPageState> emit) async {
    CommonUtils.initializeLocationAndSave(event.context);
    emit(SplashLoadingAnimationState(
        animationFirstAndLast: true, animation2: true));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(SplashLoadingAnimationState(
        animationFirstAndLast: false, animation2: true));
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(SplashLoadingAnimationState(
        animationFirstAndLast: false, animation2: false));
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(SplashLoadingAnimationState(
        animationFirstAndLast: true, animation2: true));
    await Future.delayed(const Duration(milliseconds: 1000));
    CommonUtils.authState();
  }
}
