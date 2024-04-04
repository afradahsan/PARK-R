import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class CouponsContainer extends StatelessWidget {
  const CouponsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Coupon Code',
                  style: KTextTheme.darkwhiteTextTheme.titleMedium),
              sizedwfive(context),
              Image.asset(
                'assets/confetti-ball_1f38a.png',
                height: 20,
              )
            ],
          ),
          sizedfive(context),
          const Text('Yay, you\'re saving ₹58 on this order'),
        ],
      ),
    );
  }
}
