import 'package:flutter/material.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key, required this.index});

  final int index;

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool change = true;
  int number = 0;

  void toggle() {
    setState(() {
      change = !change;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (change && widget.index == number) {
      return LoginEmail(onPressed: toggle);
    } else if (change && widget.index != number) {
      return CreateAccount(onPressed: toggle);
    } else if (change == false && widget.index != number) {
      return LoginEmail(onPressed: toggle);
    } else {
      return CreateAccount(onPressed: toggle);
    }
  }
}
