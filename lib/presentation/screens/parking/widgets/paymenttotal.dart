import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class TotalPayContainer extends StatelessWidget {
  const TotalPayContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Parking Fee',
                style: KTextTheme.darkwhiteTextTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '₹45',
                style: TextStyle(
                    color: whitet200,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          sizedfive(context),
          Row(
            children: [
              Text(
                'Complete Car Wash',
                style: KTextTheme.darkwhiteTextTheme.titleMedium,
              ),
              sizedwfive(context),
              Icon(
                Icons.verified,
                color: greenColor,
                size: 20,
              ),
              const Spacer(),
              Text(
                '₹299',
                style: TextStyle(
                    color: whitet200,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          sizedfive(context),
          Row(
            children: [
              Text(
                'Coupon Discount',
                style: KTextTheme.darkwhiteTextTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '-₹56',
                style: TextStyle(
                    color: whitet200,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          sizedten(context),
          Container(
            height: 2,
            width: double.maxFinite,
            color: whitet150,
          ),
          sizedten(context),
          Row(
            children: [
              Text(
                'Total',
                style: KTextTheme.darkwhiteTextTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '₹320',
                style: TextStyle(
                    color: whitet200,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}
