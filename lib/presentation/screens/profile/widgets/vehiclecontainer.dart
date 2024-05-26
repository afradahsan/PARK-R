import 'package:flutter/material.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/data/repositories/myvehicles/myvehicle_repo.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/profile/editvehicles.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class VehicleContainer extends StatelessWidget {
  const VehicleContainer(
      {super.key,
      required this.image,
      required this.modelName,
      required this.regNo, required this.vehicle});

  final String image;
  final String modelName;
  final String regNo;
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(105, 158, 158, 158)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset(image, height: 40)),
                sizedwten(context),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(regNo,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                )
              ],
            ),
            Positioned(
                right: -18,
                top: 0,
                child: PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Text('Edit'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return EditVehicle(vehicle: vehicle,);
                          },));
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
                                content: const Text(
                                    'Are you sure you want to delete?'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        MyVehicleRepo().deleteVehicle(context: context, vehicles: vehicle,
                                        scaffoldMessengerKey: scaffoldMessengerKey,
                                        onSuccess: () {
                                          Navigator.of(context).pop();
                                          showSnackbar(scaffoldMessengerKey, 'Deleted Successfully!');
                                        },);
                                      }, child: const Text('Yes')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No')),
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
      ),
    );
  }
}

void showSnackbar(GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, String text) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState!;
  scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
}