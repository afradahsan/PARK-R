import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/auth/loginpage.dart';
import 'package:parkr/presentation/screens/auth/verify_otp.dart';
import 'package:parkr/presentation/widgets/auth/elevatedbutton.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController phoneNoController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final AuthRepo authRepo = AuthRepo();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                'Welcome!',
                style: KTextTheme.darkTextTheme.headlineLarge,
              ),
              sizedfive(context),
              Text(
                'Please Enter Your Phone Number',
                style: KTextTheme.darkTextTheme.labelLarge,
              ),
              sizedten(context),
              TFormFeild(
                controller: phoneNoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter OTP';
                  } else {
                    return null;
                  }
                },
                hintText: 'Phone Number',
                icon: Icons.phone,
              ),
              sizedten(context),
              AuthButton(
                ButtonText: 'Continue',
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    bool userExists =
                        await checkUserExists(context, phoneNoController.text);
                    if (userExists) {
                      print('exists');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        print(phoneNoController.text);
                        return LoginPage(phoneNumber: phoneNoController.text);
                      }));
                    } else {
                      print('doesnt');
                      phoneAuthentication(phoneNoController.text, context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<bool> checkUserExists(
      BuildContext context, String phoneNoController) async {
    print('Checking user with phone number: ${phoneNoController}');
    return await authRepo.checkUser(phoneNumber: phoneNoController);
  }

  void phoneAuthentication(String phoneNo, BuildContext context) async {
    print('continue');
    await auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNo',
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'Invalid Phone number') {
            print('invalid');
            SnackBar(content: Text('Invalid'));
          } else {
            print('wrong');

            SnackBar(content: Text('Something went wrong'));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                        verificationId: verificationId,
                        phonenumber: phoneNoController.text,
                      )));
        },
        codeAutoRetrievalTimeout: ((verificationId) {}));
  }
}
