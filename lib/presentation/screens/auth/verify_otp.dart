// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/signupwemail.dart';
import 'package:parkr/presentation/screens/homepage.dart';
import 'package:parkr/presentation/widgets/auth/textformfeild.dart';
import 'package:parkr/utils/colors.dart';

class VerifyOtp extends StatelessWidget {
  final String verificationId;
  final String phonenumber;

  VerifyOtp({
    Key? key,
    required this.verificationId, required this.phonenumber,
  }) : super(key: key);

  final TextEditingController otpController = TextEditingController();
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
            TFormFeild(controller: otpController),
            ElevatedButton(onPressed: () async{
              final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);

              try {
                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupwEmail(phonenumber: phonenumber)));
              } catch (e) {
                SnackBar(content: Text('error'));
                print('erroorr');
              }
            }, child: Text('Continue'))
      ],)),
    );
  }
}
