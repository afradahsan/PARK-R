import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkr/business_logic/cubits/fetchlocation/fetchlocation_cubit.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/admin/pages/adminnav.dart';
import 'package:parkr/presentation/screens/auth/onboardingpage.dart';
import 'package:parkr/presentation/screens/home/bottomnav.dart';
import 'package:parkr/presentation/screens/owner/pages/ownernav.dart';
import 'package:parkr/utils/themes.dart';
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
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return Builder(
                  builder: (context) {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    return userProvider.user.token.isNotEmpty
                        ? userProvider.user.type == 'user'
                            ? const BottomNav()
                            : userProvider.user.type == 'admin'
                                ? const AdminNav()
                                : const OwnerNav()
                        : OnboardingPage();
                  },
                );
              },
            )));
    debugPrint('statement1');
  }

  Future<void> initializeApp() async {
    FetchlocationCubit().fetchLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Text(
        'PARK\'R',
        style: KTextTheme.darkTextTheme.headlineLarge,
      ))),
    );
  }
}
