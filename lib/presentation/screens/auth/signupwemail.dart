import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/widgets/auth/elevatedbutton.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class SignupwEmail extends StatelessWidget {
  const SignupwEmail({super.key, required this.phonenumber});

  final String phonenumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthRepo authRepo = AuthRepo();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void signupUser() {
      authRepo.signupUser(
          name: nameController.text,
          email: emailController.text,
          phone: phonenumber,
          password: passwordController.text,
          context: context);
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Create An Account!',
                style: KTextTheme.darkTextTheme.titleLarge,
              ),
              sizedten(context),
              TFormFeild(
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Name';
                  } else {
                    return null;
                  }
                },
                icon: Icons.person,
              ),
              sizedten(context),
              TFormFeild(
                icon: Icons.email,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid Email ID';
                  } else {
                    return null;
                  }
                },
                hintText: 'Email',
              ),
              sizedten(context),
              TFormFeild(
                icon: Icons.password_rounded,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  } else {
                    return null;
                  }
                },
                hintText: 'Password',
              ),
              sizedten(context),
              AuthButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      signupUser();
                    }
                  },
                  ButtonText: 'SIGN UP')
            ],
          ),
        ),
      )),
    );
  }
}
