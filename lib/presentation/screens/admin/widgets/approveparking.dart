import 'package:flutter/material.dart';
import 'package:parkr/business_logic/cubits/appproveparking/approveparking_cubit.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ApproveParking extends StatelessWidget {
  const ApproveParking({super.key, required this.parkinglotList, required this.index, required this.cubit});

  final List<ParkingModel> parkinglotList;
  final int index;
  final ApproveParkingCubit cubit;

  @override
  Widget build(BuildContext context) {
    final String parkingId = parkinglotList[index].id ?? '';
    debugPrint('parkingId: $parkingId');

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 250,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(60, 255, 255, 255),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parkinglotList[index].parkingName,
                    style: KTextTheme.darkTextTheme.titleMedium,
                  ),
                  sizedfive(context),
                  Text(
                    parkinglotList[index].locationName,
                    style: TextStyle(color: whitet150, fontSize: 16),
                  ),
                  sizedfive(context),
                  Text('${parkinglotList[index].totalSpots} spots available')
                ],
              )
            ],
          ),
        ),
        sizedwten(context),
        sizedwten(context),
        GestureDetector(
          onTap: () {
            cubit.disapprove();
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: const Icon(
                Icons.close,
                color: Colors.red,
              )),
        ),
        sizedwten(context),
        GestureDetector(
          onTap: () {
            cubit.approve();
            AdminRepo().approveParking(context: context, parkingId: parkingId, approved: cubit.state);
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: greenColor)),
              child: Icon(
                Icons.check,
                color: greenColor,
              )),
        ),
      ],
    );
  }
}
