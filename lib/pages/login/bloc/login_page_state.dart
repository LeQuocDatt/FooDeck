part of 'login_page_bloc.dart';

sealed class LoginPageState extends Equatable {
  const LoginPageState();
}

final class LoginPageInitial extends LoginPageState {
  @override
  List<Object> get props => [];
}
