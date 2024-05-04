import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/signupage.dart';
class OnboardingPage extends StatefulWidget {
  OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage(),)));
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(
        child: Text('ONBOARDING')
      ))
    );
  }
}
