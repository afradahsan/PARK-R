import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/parking/viewticket.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              color: whitet50, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Text('Booking Success!',
                  style: KTextTheme.darkTextTheme.headlineMedium),
              sizedtwenty(context),
              sizedtwenty(context),
              Image.asset(
                'assets/confetti-ball_1f38a.png',
                height: 100,
              ),
              const Spacer(),              
              TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ViewTicket(),
                      )),
                  child: Text(
                    'View Ticket',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: greenColor, decoration: TextDecoration.underline, decorationColor: greenColor),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
