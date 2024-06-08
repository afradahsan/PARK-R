import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class ResendCode extends StatefulWidget {
  ResendCode({required this.phoneNo, super.key});

  String? phoneNo;

  @override
  State<ResendCode> createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  int remaining = 30;
  Timer? _timer;
  final auth = FirebaseAuth.instance;

  void start() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (remaining <= 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          remaining--;
        });
      }
    });
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        remaining <= 0
            ? GestureDetector(
                onTap: () {
                  phoneAuthentication(widget.phoneNo!, context);
                },
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: white),
                ))
            : Text(
                remaining <= 9
                    ? 'Resend Code in 00:0$remaining'
                    : 'Resend Code in 00:$remaining',
                style: KTextTheme.darkTextTheme.bodyLarge),
      ],
    );
  }

  void phoneAuthentication(String phoneNo, BuildContext context) async {
    debugPrint('continue');
    await auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNo',
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'Invalid Phone number') {
            debugPrint('invalid');
            showSnackbar(context, 'Invalid Phone number');
          } else {
            debugPrint('wrong, $e');
            showSnackbar(context, '$e Something went wrong');
          }
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            remaining = 30;
          });
        },
        codeAutoRetrievalTimeout: ((verificationId) {}));
  }
}
