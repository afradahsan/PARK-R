import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/auth/loginpage.dart';
import 'package:parkr/presentation/screens/auth/verify_otp.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController phoneNoController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign-Up'),
            sizedten(context),
            Text('Enter Your Phone Number'),
            sizedten(context),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: phoneNoController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: greenColor),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Phone No.',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty || value.length <= 10) {
                  return 'Enter a valid phone number';
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                bool userExists =
                    await checkUserExists(context, phoneNoController.text);
                if (userExists) {
                  print('exists');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    print(phoneNoController.text);
                    return LoginPage(phoneNumber: phoneNoController.text);
                  }));
                } else {
                  print('doesnt');
                  phoneAuthentication(phoneNoController.text, context);
                }
              },
              child: Text('Continue'),
            )
          ],
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
