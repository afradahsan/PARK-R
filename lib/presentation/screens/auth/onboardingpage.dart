import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/signupage.dart';
import 'package:parkr/presentation/screens/auth/widgets/cardplanetdata.dart';
import 'package:parkr/utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final data = [
    CardPlanetData(
      title: "observe",
      subtitle:
          "The night sky has much to offer to those who seek its mystery.",
      image: const AssetImage("assets/vrs_rs245.png"),
      backgroundColor: darkbgColor,
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      // background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "imagine",
      subtitle: "An endless number of galaxies means endless possibilities.",
      image: const AssetImage("assets/himalayan_411.jpg"),
      backgroundColor: greenColor,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      // background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "stargaze",
      subtitle: "The sky dome is a beautiful graveyard of stars.",
      image: const AssetImage("assets/audi-q3.png"),
      backgroundColor: darkbgColor,
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      // background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  SignupPage()),
          );
        },
      ),
    );
  }
}
