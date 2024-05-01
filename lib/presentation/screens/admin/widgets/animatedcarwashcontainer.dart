import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/admin/widgets/tformadmin.dart';
import 'package:parkr/utils/constants.dart';

class AnimCarWash extends StatelessWidget {
  const AnimCarWash({super.key, required this.state, required this.carWashFee, required this.bikeWashFee});
  
  final bool state;
  final TextEditingController carWashFee;
  final TextEditingController bikeWashFee;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: state ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Visibility(
          visible: state,
          child: Column(
            children: [
              TFormAdmin(
                controller: carWashFee,
                hintText: 'Car Wash Fee',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Washing Fee';
                  } else {
                    return null;
                  }
                },
              ),
              sizedten(context),
              TFormAdmin(
                controller: bikeWashFee,
                hintText: 'Bike Wash Fee',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Washing Fee';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          )),
    );
  }
}
