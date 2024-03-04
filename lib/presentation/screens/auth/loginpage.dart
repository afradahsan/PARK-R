import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/widgets/auth/elevatedbutton.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    AuthRepo authRepo = AuthRepo();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void signinUser(String password, String phoneNo) {
      authRepo.signinUser(phone: phoneNo, password: password, context: context);
    }

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back! 👋',
            style: KTextTheme.darkTextTheme.titleLarge,
          ),
          Text(
            'Log in to continue',
            style: KTextTheme.darkTextTheme.titleSmall,
          ),
          sizedten(context),
          TFormFeild(
            icon: Icons.password_rounded,
            controller: passwordController,
            hintText: 'Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid Password';
              } else {
                return null;
              }
            },
          ),
          sizedten(context),
          AuthButton(
              onPressed: () {
              signinUser(passwordController.text, phoneNumber);
              },
              ButtonText: 'Log In')
        ],
      ),
    )));
  }
}
