import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';
import 'package:provider/provider.dart';

class ChooseVehiclesContainer extends StatelessWidget {
  const ChooseVehiclesContainer({Key? key, required this.myvehiclesList}) : super(key: key);

  final List<Vehicle> myvehiclesList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectvehindexCubit, int>(
      builder: (context, selectedIndex) {
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.read<SelectvehindexCubit>().updateSelectedIndex(index);
              },
              child: mainContainer(myvehiclesList, context, index, selectedIndex),
            );
          },
          separatorBuilder: (context, index) {
            return sizedten(context);
          },
          itemCount: myvehiclesList.length,
        );
      },
    );
  }
}

Widget mainContainer(List<Vehicle> myvehiclesList, final BuildContext context, int index, int selectedIndex) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    height: 80,
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: whitet50,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: selectedIndex == index ? greenColor : Colors.transparent, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          child: Image.asset(
            myvehiclesList[index].vehicleType == 'Four Wheeler' ? 'assets/audi-q3.png' : 'assets/himalayan_411.jpg',
          ),
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
        Icon(
          selectedIndex == index ? Icons.radio_button_checked : Icons.radio_button_off,
          color: selectedIndex == index ? greenColor : white,
        ),
      ],
    ),
  );
}