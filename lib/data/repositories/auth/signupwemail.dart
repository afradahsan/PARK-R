import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/signin/bloc/signin_bloc.dart';
import 'package:parkr/business_logic/signup/bloc/signup_bloc.dart';
import 'package:parkr/data/models/usermodel.dart';
import 'package:parkr/presentation/screens/auth/widgets/elevatedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/auth/widgets/textformfeild.dart';
import 'package:parkr/presentation/screens/home/bottomnav.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class SignupwEmail extends StatelessWidget {
  SignupwEmail({super.key, required this.phonenumber});

  final String phonenumber;
  final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
              BlocListener<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const BottomNav();
                    }));
                  } else if (state is SignUpTryAgainState) {
                    showSnackbar(context, 'Try Again');
                  } else if (state is SignUpErrorState){
                    showSnackbar(context, 'Error');
                  }
                },
                child: AuthButton(
                    onPressed: () {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(SigningUpEvent(
                            user: UserModel(
                                id: '',
                                name: nameController.text,
                                email: emailController.text,
                                phone: phonenumber,
                                password: passwordController.text,
                                type: '',
                                token: '')));
                      }
                    },
                    ButtonText: 'SIGN UP'),
              )
            ],
          ),
        ),
      )),
    );
  }
}
