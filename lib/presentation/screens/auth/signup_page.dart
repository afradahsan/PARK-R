import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/verify_otp.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController phoneNoController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
            ElevatedButton(onPressed: () {
              phoneAuthentication("+91${phoneNoController.text}", context);
              print('continue');
            }, child: Text('Continue'))
          ],
        ),
      )),
    );
  }

  void phoneAuthentication(String phoneNo, BuildContext context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtp(verificationId: verificationId, phonenumber: phoneNoController.text,)));
        },
        codeAutoRetrievalTimeout: ((verificationId) {}));
  }
}
