import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/utils/colors.dart';

class BikeChoiceChipWidget extends StatelessWidget {
  const BikeChoiceChipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BikeChoiceChipCubit, bool>(
      builder: (context, state) {
        return ChoiceChip(
          showCheckmark: false,
          label: const Text('Bike'),
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
            context.read<BikeChoiceChipCubit>().toggle(selected);
            context.read<CarChoiceChipCubit>().toggle(!selected);
            context.read<TruckChoiceChipCubit>().toggle(!selected);
            debugPrint(state.toString());
          },
        );
      },
    );
  }
}
