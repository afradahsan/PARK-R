// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/signupwemail.dart';
import 'package:parkr/presentation/screens/auth/widgets/elevatedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/resend_code.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/auth/widgets/textformfeild.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  final String phonenumber;

  const VerifyOtp({
    Key? key,
    required this.verificationId,
    required this.phonenumber,
  }) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
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
              sizedfive(context),
              Text(
                'The OTP has been sent to +91 ${widget.phonenumber}',
                style: KTextTheme.darkwhiteTextTheme.labelMedium ,
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
              ResendCode(phoneNo: widget.phonenumber,),
              sizedfive(context),
              AuthButton(
                loading: false,
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      {
                        final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: otpController.text);

                        try {
                          await auth.signInWithCredential(credential);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignupwEmail(phonenumber: widget.phonenumber)));
                        } catch (e) {
                          showSnackbar(context, 'Wrong OTP');
                          debugPrint('erroorr');
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