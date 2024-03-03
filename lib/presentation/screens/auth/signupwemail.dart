import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';

class SignupwEmail extends StatelessWidget {
  const SignupwEmail({super.key, required this.phonenumber});

  final String phonenumber;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthRepo authRepo = AuthRepo();

    void signupUser(){
      authRepo.signupUser(name: nameController.text, email: emailController.text, phone: phonenumber, password: passwordController.text, context: context);
    }

    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Welcome'),
        Text('Create an Account to continue!'),
        TFormFeild(controller: nameController),
        TFormFeild(controller: emailController),
        TFormFeild(controller: passwordController),
        ElevatedButton(onPressed: (){
          signupUser();
        }, child: Text('SIGN UP'))
      ],)),
    );
  }
}