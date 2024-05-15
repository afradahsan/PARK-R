import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Lottie.asset('assets/animations/comingsoonraw.json', fit: BoxFit.cover),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Stay tuned. We\'re Working on it!'),
          ],
        )
      ],)),
    );
  }
}