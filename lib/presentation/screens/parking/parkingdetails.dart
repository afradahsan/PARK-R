import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/parkingdetails/parkingdetails_bloc.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingdetailswidget.dart';
import 'package:parkr/utils/colors.dart';

class ParkingDetails extends StatelessWidget {
  const ParkingDetails({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ParkingdetailsBloc, ParkingdetailsState>(
              builder: (context, state) {
                if (state is ParkingdetailsInitial) {
                  context
                      .read<ParkingdetailsBloc>()
                      .add(ParkingdescEvent(id: index));
                  return CircularProgressIndicator(color: greenColor);
                } else if (state is ParkingDetailsSuccessState) {
                  return ParkingDWidget(parkinglist: state.parkingList, index: index,);
                } else if (state is ParkingDetailsErrorState) {
                  return const Text('Error: Failed to load parking details');
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
