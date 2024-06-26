import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/parking/couponspage.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class CouponsContainer extends StatelessWidget {
  const CouponsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const CouponPage();
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 85,
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
            const Text('Tap to reveal your coupons!'),
          ],
        ),
      ),
    );
  }
}
