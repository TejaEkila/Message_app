//import 'package:easylazy/home.dart';
import 'package:easylazy/home2.dart';
import 'package:easylazy/servies/loginorreg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user logged in
          if (snapshot.hasData) {
            return const Home2();
          }
          //if user not logged in
          else {
            return const LoginorRegister();
          }
        },
      ),
    );
  }
}
