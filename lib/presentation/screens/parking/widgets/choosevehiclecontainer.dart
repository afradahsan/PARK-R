import 'package:flutter/material.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseVehiclesContainer extends StatefulWidget {
  const ChooseVehiclesContainer({super.key, required this.myvehiclesList});

  final List<Vehicle> myvehiclesList;

  @override
  State<ChooseVehiclesContainer> createState() => _ChooseVehiclesContainerState();
}

class _ChooseVehiclesContainerState extends State<ChooseVehiclesContainer> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: mainContainer(widget.myvehiclesList, context, index, selectedIndex));
        },
        separatorBuilder: (context, index) {
          return sizedten(context);
        },
        itemCount: widget.myvehiclesList.length);
  }
}

Widget mainContainer(List<Vehicle> myvehiclesList, final BuildContext context, int index, int selectedIndex) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    height: 80,
    width: double.maxFinite,
    decoration:
        BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15),
          border: selectedIndex == index ? Border.all(color: greenColor, width: 1) : Border.all(width: 0)
          ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          child: Image.asset(myvehiclesList[index].vehicleType == 'Four Wheeler'
                      ? 'assets/audi-q3.png'
                      : 'assets/himalayan_411.jpg'),
        ),
        sizedwten(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myvehiclesList[index].vehicleName,
              style: KTextTheme.darkwhiteTextTheme.titleLarge,
            ),
            Text(
              myvehiclesList[index].vehicleNumber,
              style: KTextTheme.darkTextTheme.labelLarge,
            )
          ],
        ),
        const Spacer(),
        selectedIndex==index ? Icon(Icons.radio_button_checked, color: greenColor,) : Icon(
          Icons.radio_button_off,
          color: white,
        )
      ],
    ),
  );
}
