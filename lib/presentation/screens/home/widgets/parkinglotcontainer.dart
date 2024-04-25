import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/business_logic/cubits/showtruck/showtruckcubit.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/parking/parkingdetails.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingLotContainer extends StatelessWidget {
  const ParkingLotContainer(
      {super.key, required this.parkinglotList, required this.index});

  final List<ParkingModel> parkinglotList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTruckCubit, bool>(
      builder: (context, state) {
        final showTruck = context.watch<ShowTruckCubit>().state;

        if (showTruck && parkinglotList[index].truckparkingFee == 0) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ParkingDetails(
                  index: index,
                );
              },
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(60, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    parkinglotList[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
                sizedwten(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parkinglotList[index].parkingName,
                      style: KTextTheme.darkTextTheme.titleMedium,
                    ),
                    Text(
                      parkinglotList[index].locationName,
                      style: const TextStyle(
                          color: Color.fromARGB(130, 255, 255, 255),
                          fontSize: 14),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/Rupee3x.png',
                          height: 30,
                        ),
                        context.watch<CarChoiceChipCubit>().state
                            ? Text(
                                '${parkinglotList[index].carparkingFee.toString()}/hr')
                            : context.watch<BikeChoiceChipCubit>().state
                                ? Text(
                                    '${parkinglotList[index].bikeparkingFee.toString()}/hr')
                                : parkinglotList[index].truckparkingFee == 0
                                    ? context
                                        .read<ShowTruckCubit>()
                                        .show(context)
                                    : Text(
                                        '${parkinglotList[index].truckparkingFee.toString()}/hr')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
