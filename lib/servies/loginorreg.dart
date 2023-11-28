import 'package:easylazy/login_pages/login.dart';
import 'package:easylazy/login_pages/register_page.dart';
import 'package:flutter/material.dart';


class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  //intilly show the login_page
  bool showloginpage = true;

  //toggle b/w login and register
  void togglepress() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return loginpage(onTap: togglepress);
    } else {
      return Register(onTap: togglepress);
    }
  }
}
