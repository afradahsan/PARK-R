import 'package:flutter/material.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseVehiclesContainer extends StatelessWidget {
  const ChooseVehiclesContainer({super.key, required this.myvehiclesList});

  final List<Vehicle> myvehiclesList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (context, index) {
          return mainContainer(myvehiclesList, context, index);
        },
        separatorBuilder: (context, index) {
          return sizedten(context);
        },
        itemCount: myvehiclesList.length);
  }
}

Widget mainContainer(List<Vehicle> myvehiclesList, final BuildContext context, int index) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    height: 100,
    width: double.maxFinite,
    decoration:
        BoxDecoration(color: whitet50, borderRadius: BorderRadius.circular(15)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/audi-q3.png'),
        sizedwten(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myvehiclesList[index].vehicleName,
              style: KTextTheme.darkTextTheme.titleLarge,
            ),
            Text(
              myvehiclesList[index].vehicleNumber,
              style: TextStyle(color: whitet200, fontSize: 12),
            )
          ],
        ),
        const Spacer(),
        Icon(
          Icons.radio_button_off,
          color: white,
        )
      ],
    ),
  );
}
