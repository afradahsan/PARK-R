import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/admin/widgets/tformadmin.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingFeeContainer extends StatelessWidget {
  const ParkingFeeContainer({super.key, required this.carparkingFee, required this.bikeparkingFee, required this.truckparkingFee});

  final TextEditingController carparkingFee;
  final TextEditingController bikeparkingFee;
  final TextEditingController truckparkingFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Parking Fee', style: KTextTheme.darkTextTheme.titleSmall,),
        sizedfive(context),
        Row(
          children: [
            Expanded(
              child: TFormAdmin(
                controller: carparkingFee,
                hintText: 'Car Parking Fee',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the Fee, Set 0 if not available';
                  } else {
                    return null;
                  }
                },
                textinputtype: TextInputType.number,
              ),
            ),
            sizedwten(context),
            Expanded(
              child: TFormAdmin(
                controller: bikeparkingFee,
                hintText: 'Bike Parking Fee',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the Fee, Set 0 if not available';
                  } else {
                    return null;
                  }
                },
                textinputtype: TextInputType.number,
              ),
            ),
          ],
        ),
        sizedten(context),
        TFormAdmin(
          controller: truckparkingFee,
          hintText: 'Truck Parking Fee (Set zero if null)',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter the Fee, Set 0 if not available';
            } else {
              return null;
            }
          },
          textinputtype: TextInputType.number,
        ),
      ],
    );
  }
}
