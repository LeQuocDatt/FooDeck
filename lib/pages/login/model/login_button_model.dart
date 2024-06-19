import 'package:template/source/export.dart';

class LoginButton {
  final String type;
  final String loginText;
  final Color backGroundColor;

  LoginButton(this.type, this.loginText, this.backGroundColor);

  static List<LoginButton> loginButton = [
    LoginButton(Assets.googleLogo, 'Login via Google', AppColor.buttonRed),
    LoginButton(Assets.facebookLogo, 'Login via Facebook', AppColor.buttonBlue),
    LoginButton(Assets.appleLogo, 'Login via Apple', Colors.black),
    LoginButton(Assets.emailLogo, 'Login via Email', AppColor.globalPink),
    LoginButton('', 'Create an account', Colors.white)
  ];
}
