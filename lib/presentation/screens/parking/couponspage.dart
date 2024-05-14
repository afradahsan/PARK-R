import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Lottie.asset('assets/animations/comingsoonraw.json'),
      )),
    );
  }
}