// ignore_for_file: prefer_const_constructors, camel_case_types, use_build_context_synchronously

import 'package:easylazy/components/mybutton.dart';
import 'package:easylazy/components/mytextfield.dart';
import 'package:easylazy/servies/auth_server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginpage extends StatefulWidget {
  final void Function()? onTap;
  const loginpage({super.key, required this.onTap});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //user signin
  void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthServer>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('invaild email or password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: SafeArea(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                //icon_logo
                Icon(
                  Icons.forum,
                  size: 120,
                  color: Color.fromRGBO(
                    133,
                    127,
                    247,
                    1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Welcome to EasyLazy!!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    '#Make Your Chat Lazy',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //name field
                mytextfield(
                    Controller: emailController,
                    hinttext: 'e-mail',
                    obscureText: false,
                   ),
      
                SizedBox(
                  height: 30,
                ),
                //password field
                mytextfield(
                    Controller: passwordController,
                    hinttext: 'password',
                    obscureText: true,
                    ),
                SizedBox(
                  height: 40,
                ),
                //my button
                Mybutton(
                    //sign in
                    buttontext: 'login',
                    ontap: signIn),
                SizedBox(
                  height: 20,
                ),
                //create account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Color.fromRGBO(
                            133,
                            127,
                            247,
                            1,
                          ),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
