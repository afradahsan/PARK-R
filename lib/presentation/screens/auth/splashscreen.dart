import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkr/business_logic/cubits/fetchlocation/fetchlocation_cubit.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/admin/pages/adminnav.dart';
import 'package:parkr/presentation/screens/auth/onboardingpage.dart';
import 'package:parkr/presentation/screens/home/bottomnav.dart';
import 'package:parkr/presentation/screens/owner/pages/ownernav.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('statement');
    initializeApp();
    Timer(const Duration(seconds: 3), navigateToNextScreen);
    debugPrint('statement1');
  }

  Future<void> initializeApp() async {
    FetchlocationCubit().fetchLocation();
  }

  void navigateToNextScreen() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    Widget nextPage;
    if (userProvider.user.token.isNotEmpty) {
      if (userProvider.user.type == 'user') {
        debugPrint('user');
        nextPage = const BottomNav();
      } else if (userProvider.user.type == 'admin') {
        debugPrint('user');
        nextPage = const AdminNav();
      } else {
        debugPrint('owner');
        nextPage = const OwnerNav();
      }
    } else {
      debugPrint('onbiard');
      nextPage = OnboardingPage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Image.asset('assets/parkwiser-logo.png', height: 250,))),
    );
  }
}
