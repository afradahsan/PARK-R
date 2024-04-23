import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class PayMethodContainer extends StatelessWidget {
  const PayMethodContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 175,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        row('assets/Googlepay.png', 'Google Pay', context),
        sizedten(context),
        row('assets/PhonePe.png', 'Phone Pe', context),
        sizedten(context),
        row('assets/credit-card_1f4b3.png', 'Credit/Debit Cards', context),
      ]),
    );
  }
}

Widget row(String image, String text, BuildContext context) {
  return GestureDetector(
    child: Row(
      children: [
        Image.asset(
          image,
          height: 40,
        ),
        sizedwten(context),
        Text(
          text,
          style: KTextTheme.darkwhiteTextTheme.titleMedium,
        )
      ],
    ),
  );
}
