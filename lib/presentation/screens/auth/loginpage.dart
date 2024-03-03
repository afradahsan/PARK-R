import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Text('Welcome Back! 👋'),
        Text('Sign in to continue'),
        TFormFeild(controller: passwordController),
      ],
    )));
  }
}
