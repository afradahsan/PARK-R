import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/wash/wash_cubit.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class IncludeWash extends StatelessWidget {
  const IncludeWash({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Include Washing',
              style: KTextTheme.darkwhiteTextTheme.titleMedium,
            ),
            Text(
              'Price ranges between ₹299 to ₹499',
              style: KTextTheme.darkwhiteTextTheme.labelMedium,
            )
          ],
        ),
        const Spacer(),
        BlocBuilder<WashCubit, bool>(
          builder: (context, wash) {
            return IconButton(
                onPressed: () {
                  context.read<WashCubit>().updateIncWash();  
                },
                icon: wash==true
                    ? Icon(
                        Icons.toggle_on,
                        color: greenColor,
                        size: 40,
                      )
                    : const Icon(
                        Icons.toggle_off,
                        color: Colors.grey,
                        size: 40,
                      ));
          },
        )
      ],
    );
  }
}
