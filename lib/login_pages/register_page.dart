// ignore_for_file: use_build_context_synchronously

import 'package:easylazy/components/mybutton.dart';
import 'package:easylazy/components/mytextfield.dart';
import 'package:easylazy/servies/auth_server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password do not match!')),
      );
      return;
    }
    final authServiec = Provider.of<AuthServer>(context, listen: false);
    try {
      await authServiec.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
// get auth serivecs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //icon_logo
                const Icon(
                  Icons.forum,
                  size: 120,
                  color: Color.fromRGBO(
                    133,
                    127,
                    247,
                    1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Let\'s create an account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
          
                //name field
                // mytextfield(
                //     Controller: usernameController,
                //     hinttext: 'username',
                //     obscureText: false,
                //     validator: (value) {}
                //     ),
                const SizedBox(
                  height: 20,
                ),
                //email
                mytextfield(
                    Controller: emailController,
                    hinttext: 'e-mail',
                    obscureText: false,
                    ),
                const SizedBox(
                  height: 20,
                ),
                //password field
                mytextfield(
                    Controller: passwordController,
                    hinttext: 'password',
                    obscureText: true,
                    ),
                const SizedBox(
                  height: 20,
                ),
                mytextfield(
                  Controller: confirmpasswordController,
                  hinttext: 'confirm password',
                  obscureText: true,
                  
                ),
                const SizedBox(
                  height: 30,
                ),
                //my button
                Mybutton(
                  buttontext: 'submit',
                  ontap: signUp,
                ),
                const SizedBox(
                  height: 10,
                ),
                //create account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: signUp,
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
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
