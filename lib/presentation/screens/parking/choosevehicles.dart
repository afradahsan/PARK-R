import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/parking/choseparking.dart';
import 'package:parkr/presentation/screens/parking/widgets/choosevehiclecontainer.dart';
import 'package:parkr/presentation/screens/parking/widgets/includewash.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/presentation/screens/profile/addvehicle.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseVehicle extends StatelessWidget {
  const ChooseVehicle({super.key, required this.parkingList, required this.index});

  final List<ParkingModel> parkingList;
  final int index;

  @override
  Widget build(BuildContext context) {
    String parkingname = parkingList[index].parkingName;
    String myVehNumber = '';
    String vehicletype = '';
    
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your Vehicle:',
              style: KTextTheme.darkwhiteTextTheme.titleLarge,
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
                  final selectedIndex = context.read<SelectvehindexCubit>().state;
                  myVehNumber = state.myVehicles[selectedIndex].vehicleNumber;
                  vehicletype = state.myVehicles[selectedIndex].vehicleType;

                  return Column(
                    children: [
                      ChooseVehiclesContainer(
                        myvehiclesList: state.myVehicles,
                      ),
                      sizedten(context),
                      addvehContainer(context),
                      sizedtwenty (context),
                      parkingList[index].carWash ? const IncludeWash() : sizedten(context)
                    ],
                  );
                } else if (state is MyVehiclesError) {
                  return const Text('Error: Failed to load parking details');
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
            const Spacer(),
            ParkingButton(text: 'Proceed', onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChooseParking(parkingname: parkingname, vehicleType: vehicletype, index: index,);
              },));
            })
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

Widget addvehContainer(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const AddVehicle();
      },));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: double.maxFinite,
      decoration:
          BoxDecoration(color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            color: greenColor,
          ),
          sizedwten(context),
          Text(
            'Add Another Vehicle',
            style: KTextTheme.darkwhiteTextTheme.titleMedium,
          )
        ],
      ),
    ),
  );
}