import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/addparking_cubit/addparking_cubit.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class CheckBoxes extends StatelessWidget {
  const CheckBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          BlocBuilder<IndoorCubit, bool>(
            builder: (context, state) {
              return Checkbox(
                  checkColor: darkbgColor,
                  activeColor: greenColor,
                  value: state,
                  onChanged: ((value) {
                    context.read<IndoorCubit>().toggle();
                  }));
            },
          ),
          Text('Indoor Parking'),
        ],
      ),
      Row(
        children: [
          BlocBuilder<CarWashCubit, bool>(
            builder: (context, state) {
              return Checkbox(
                  checkColor: darkbgColor,
                  activeColor: greenColor,
                  value: state,
                  onChanged: ((value) {
                    debugPrint(state.toString());
                    context.read<CarWashCubit>().toggle();
                  }));
            },
          ),
          const Text('Wash'),
          sizedwten(context),
          BlocBuilder<EvChargeCubit, bool>(
            builder: (context, state) {
              return Checkbox(
                  checkColor: darkbgColor,
                  activeColor: greenColor,
                  value: state,
                  onChanged: ((value) {
                    context.read<EvChargeCubit>().toggle();
                  }));
            },
          ),
          const Text('EV Charging'),
        ],
      )
    ]);
  }
}
