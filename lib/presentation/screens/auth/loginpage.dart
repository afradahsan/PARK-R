import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    AuthRepo authRepo = AuthRepo();

    void signinUser(String password, String phoneNo) {
      authRepo.signinUser(phone: phoneNo, password: password, context: context);
    }

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Text('Welcome Back! 👋'),
        Text('Log in to continue'),
        TFormFeild(controller: passwordController),
        ElevatedButton(onPressed: (){
          print(phoneNumber);
          signinUser(passwordController.text, phoneNumber);
        }, child: Text('Login'))
      ],
    )));
  }
}
