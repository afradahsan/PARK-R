// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/signupwemail.dart';
import 'package:parkr/presentation/screens/home/homepage.dart';
import 'package:parkr/presentation/screens/auth/widgets/elevatedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/grayedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/textformfeild.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class VerifyOtp extends StatelessWidget {
  final String verificationId;
  final String phonenumber;

  VerifyOtp({
    Key? key,
    required this.verificationId,
    required this.phonenumber,
  }) : super(key: key);

  final TextEditingController otpController = TextEditingController();
  final auth = FirebaseAuth.instance;
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
                'Enter the OTP',
                style: KTextTheme.darkTextTheme.titleLarge,
              ),
              sizedten(context),
              TFormFeild(
                icon: Icons.timelapse_rounded,
                controller: otpController,
                hintText: 'OTP',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter OTP';
                  } else {
                    return null;
                  }
                },
              ),
              sizedten(context),
              GrayedButton(onPressed: (){}, ButtonText: 'Resend Code'),
              sizedfive(context),
              AuthButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      {
                        final credential = PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text);

                        try {
                          await auth.signInWithCredential(credential);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignupwEmail(phonenumber: phonenumber)));
                        } catch (e) {
                          SnackBar(content: Text('error'));
                          print('erroorr');
                        }
                      }
                      ;
                    }
                  },
                  ButtonText: 'Verify'),
            ],
          ),
        ),
      )),
    );
  }
}
