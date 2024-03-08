import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/signin/bloc/signin_bloc.dart';
import 'package:parkr/presentation/screens/navscreens.dart/bottomnav.dart';
import 'package:parkr/presentation/widgets/auth/elevatedbutton.dart';
import 'package:parkr/presentation/widgets/auth/snackbar.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.phoneNumber});

  final String phoneNumber;
  final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // void signinUser(String password, String phoneNo) {
    //   authRepo.signinUser(phone: phoneNo, password: password, context: context);
    // }

    return Scaffold(
        body: SafeArea(
            child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Back! 👋',
                style: KTextTheme.darkTextTheme.titleLarge),
            Text('Log in to continue',
                style: KTextTheme.darkTextTheme.titleSmall),
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
                }),
            sizedten(context),
            BlocListener<SigninBloc, SigninState>(
              listener: (context, state) {
                if (state is SigninSuccessState) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const BottomNav();
                  }));
                } else if (state is SigninErrorState) {
                  showSnackbar(context, 'Password Doesn\'t Match');
                }
              },
              child: AuthButton(
                  onPressed: () {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                          context.read<SigninBloc>().add(SigningInEvent(password: passwordController.text, phoneNo: phoneNumber));
                        }
                  },
                  ButtonText: 'Log In'),
            )
          ],
        ),
      ),
    )));
  }
}
