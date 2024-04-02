import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/presentation/screens/parking/widgets/choosevehiclecontainer.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseVehicle extends StatelessWidget {
  const ChooseVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your Vehicle:',
              style: KTextTheme.darkTextTheme.titleLarge,
            ),
            sizedten(context),
            BlocBuilder<MyvehiclesBloc, MyvehiclesState>(
              builder: (context, state) {
                if (state is MyvehiclesInitial) {
                  context
                      .read<MyvehiclesBloc>()
                      .add(const FetchVehiclesEvent());
                  return CircularProgressIndicator(
                    color: greenColor,
                  );
                } else if (state is MyVehiclesLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MyVehiclesSuccess) {
                  return ChooseVehiclesContainer(myvehiclesList: state.myVehicles,);
                } else if (state is MyVehiclesError) {
                  return const Text('Error: Failed to load parking details');
                } else {
                  return const Text('Unknown state');
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

AppBar appbar() {
  return AppBar(
    title: Text(
      'Details',
      style: KTextTheme.darkTextTheme.titleLarge,
    ),
    iconTheme: IconThemeData(color: greenColor),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
