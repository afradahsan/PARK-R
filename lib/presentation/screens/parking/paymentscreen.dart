import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/parking/widgets/coupons.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/presentation/screens/parking/widgets/paymentmethod.dart';
import 'package:parkr/presentation/screens/parking/widgets/paymenttotal.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

import '../../../utils/themes.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Amount',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const TotalPayContainer(),
            sizedtwenty(context),
            Text('Choose Payment Method',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const PayMethodContainer(),
            sizedtwenty(context),
            Text('Offers & Benefits',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const CouponsContainer(),
            const Spacer(),
            ParkingButton(text: 'Tap to Pay', onpressed: (){})
          ],
        ),
      )),
    );
  }
}

AppBar appbar() {
  return AppBar(
    title: Text(
      'Confirmation',
      style: KTextTheme.darkTextTheme.titleLarge,
    ),
    iconTheme: IconThemeData(color: greenColor),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}