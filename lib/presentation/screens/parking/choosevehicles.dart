import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/auth/widgets/grayedbutton.dart';
import 'package:parkr/presentation/screens/parking/choseparking.dart';
import 'package:parkr/presentation/screens/parking/widgets/choosevehiclecontainer.dart';
import 'package:parkr/presentation/screens/parking/widgets/includewash.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/presentation/screens/profile/addvehicle.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';
import 'package:shimmer/shimmer.dart';

class ChooseVehicle extends StatelessWidget {
  const ChooseVehicle({super.key, required this.parkingList, required this.index});

  final List<ParkingModel> parkingList;
  final int index;

  @override
  Widget build(BuildContext context) {
    String parkingname = parkingList[index].parkingName;
    String myVehNumber = '';
    String vehicletype = '';

    context.read<MyvehiclesBloc>().add(const FetchVehiclesEvent());

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
            BlocListener<MyvehiclesBloc, MyvehiclesState>(
              listener: (context, state) {
                if (state is MyVehiclesSuccess) {
                  final selectedIndex = context.read<SelectvehindexCubit>().state;
                  myVehNumber = state.myVehicles[selectedIndex].vehicleNumber;
                  vehicletype = state.myVehicles[selectedIndex].vehicleType;
                }
              },
              child: BlocBuilder<MyvehiclesBloc, MyvehiclesState>(
                builder: (context, state) {
                  if (state is MyvehiclesInitial || state is MyVehiclesLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 80,
                                  width: screenW(context),
                                  decoration: BoxDecoration(
                                      color: whitet50,
                                      borderRadius: BorderRadius.circular(15)),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return sizedten(context);
                              },
                              itemCount: 4),
                          sizedten(context),
                          Container(
                            height: 10,
                            width: screenW(context) - 300,
                            decoration: BoxDecoration(
                                color: whitet50,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          sizedten(context),
                          Container(
                            height: 10,
                            width: screenW(context) - 200,
                            decoration: BoxDecoration(
                                color: whitet50,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MyVehiclesSuccess) {
                    final selectedIndex = context.read<SelectvehindexCubit>().state;
                    myVehNumber = state.myVehicles[selectedIndex].vehicleNumber;
                    vehicletype = state.myVehicles[selectedIndex].vehicleType;

                    return Column(
                      children: [
                        SizedBox(
                          height: 430,
                          child: ChooseVehiclesContainer(
                            myvehiclesList: state.myVehicles,
                          ),
                        ),
                        sizedten(context),
                        addvehContainer(context),
                        sizedtwenty(context),
                        parkingList[index].carWash ? const IncludeWash() : sizedten(context)
                      ],
                    );
                  } else if (state is MyVehiclesEmptyState) {
                    return SizedBox(
                      width: double.maxFinite,
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/7317981.png',
                            height: 180,
                          ),
                          Text(
                            'No Vehicles Found!',
                            style: KTextTheme.darkwhiteTextTheme.titleMedium,
                          ),
                          sizedfive(context),
                          Text(
                            'Add your vehicle to continue',
                            style: KTextTheme.darkTextTheme.bodyMedium,
                          ),
                          sizedten(context),
                          addvehContainer(context),
                        ],
                      ),
                    );
                  } else if (state is MyVehiclesError) {
                    return const Text('Error: Failed to load parking details');
                  } else {
                    return const Text('Unknown state');
                  }
                },
              ),
            ),
            const Spacer(),
            BlocBuilder<MyvehiclesBloc, MyvehiclesState>(
              builder: (context, state) {
                if (state is MyVehiclesSuccess) {
                  return ParkingButton(
                    text: 'Proceed',
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ChooseParking(
                            parkingname: parkingname,
                            vehicleType: vehicletype,
                            index: index,
                          );
                        },
                      ));
                    });
                } else {
                  return GrayedButton(onPressed: () {}, ButtonText: 'Proceed');
                }
              },
            ),
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
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const AddVehicle();
        },
      ));
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            color: greenColor,
          ),
          sizedwten(context),
          Text(
            'Add New Vehicle',
            style: KTextTheme.darkwhiteTextTheme.titleMedium,
          )
        ],
      ),
    ),
  );
}
