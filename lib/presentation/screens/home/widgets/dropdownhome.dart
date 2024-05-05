import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/utils/colors.dart';

class DropDownhome extends StatefulWidget {
  const DropDownhome({super.key});

  @override
  State<DropDownhome> createState() => _DropDownhomeState();
}

class _DropDownhomeState extends State<DropDownhome> {
 

  @override
  Widget build(BuildContext context) {
    bool bike = context.read<BikeChoiceChipCubit>().state;
    bool car = context.read<CarChoiceChipCubit>().state;
    bool truck = context.read<TruckChoiceChipCubit>().state;

    VehicleIcon selectedveh = VehicleIcon(bike ? Icons.motorcycle : car ? Icons.drive_eta : Icons.fire_truck,  greenColor);

    debugPrint('$bike, $car, $truck');
    return Container(
      height: 48,
      width: 72,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<VehicleIcon>(
          hint: Icon(selectedveh.icon, color: greenColor,),
          disabledHint: Icon(selectedveh.icon, color: greenColor,),
          items: <VehicleIcon>[
            VehicleIcon(Icons.motorcycle, greenColor),
            VehicleIcon(Icons.drive_eta, greenColor),
            VehicleIcon(Icons.fire_truck, greenColor)
          ].map((VehicleIcon value) {
            return DropdownMenuItem<VehicleIcon>(
              value: value,
              child: Icon(value.icon, color: value.color),
            );
          }).toList(),
          onChanged: (newvalue) {
            newvalue?.icon == Icons.motorcycle ? bike = true : bike = false;
            newvalue?.icon == Icons.drive_eta ? car = true : car = false;
            newvalue?.icon == Icons.fire_truck ? truck = true : truck = false;
            context.read<BikeChoiceChipCubit>().toggle(bike);
            context.read<CarChoiceChipCubit>().toggle(car);
            context.read<TruckChoiceChipCubit>().toggle(truck);
            setState(() {
              selectedveh = newvalue!;
            });
          },
          isExpanded: true,
          menuMaxHeight: 160,
          itemHeight: null,
          elevation: 1,
          iconEnabledColor: greenColor,
          focusColor: white,
          dropdownColor: darkbgColor,
          borderRadius: BorderRadius.circular(15),
          underline: Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: whitet200),
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}

class VehicleIcon {
  final IconData icon;
  final Color color;

  VehicleIcon(this.icon, this.color);
}