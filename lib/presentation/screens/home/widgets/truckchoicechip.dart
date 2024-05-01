import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/utils/colors.dart';

class TruckChoiceChipWidget extends StatelessWidget {
  const TruckChoiceChipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TruckChoiceChipCubit, bool>(
      builder: (context, state) {
        return ChoiceChip(
          showCheckmark: false,
          label: const Text('Truck'),
          labelStyle: state
              ? TextStyle(color: darkbgColor)
              : TextStyle(color: greenColor),
          backgroundColor: Colors.transparent,
          disabledColor: Colors.amber,
          elevation: 0,
          selectedColor: greenColor,
          side: state
              ? BorderSide(color: white, width: 0)
              : BorderSide(color: white, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          selected: state,
          onSelected: (selected) {
            context.read<TruckChoiceChipCubit>().toggle(selected);
            context.read<CarChoiceChipCubit>().toggle(!selected);
            context.read<BikeChoiceChipCubit>().toggle(!selected);
            debugPrint(state.toString());
          },
        );
      },
    );
  }
}
