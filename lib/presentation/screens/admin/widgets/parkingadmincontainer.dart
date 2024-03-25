import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/pages/editparking.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingAdminContainer extends StatelessWidget {
  const ParkingAdminContainer(
      {super.key, required this.parkinglotList, required this.index});

  final List<ParkingModel> parkinglotList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(60, 255, 255, 255),
      ),
      child: Stack(
        children: [
          Row(
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
                      Text('${parkinglotList[index].parkingFee.toString()}/hr')
                    ],
                  )
                ],
              )
            ],
          ),
          Positioned(
              right: -14,
              top: -6,
              child: PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EditParking(
                                parkinglotList: parkinglotList, index: index);
                          },
                        ));
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: darkbgColor,
                              content: const Text('Are you sure you want to delete?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      AdminRepo().deleteParking(
                                          context: context,
                                          parkingModel:parkinglotList[index],
                                          onSuccess: () {
                                            parkinglotList.removeAt(index);
                                          });
                                      Navigator.pop(context);
                                    },
                                    child: Text('Yes')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ];
                },
              ))
        ],
      ),
    );
  }
}
