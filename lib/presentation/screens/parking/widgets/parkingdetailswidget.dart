import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/parking/choosevehicles.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingDWidget extends StatelessWidget {
  const ParkingDWidget(
      {super.key, required this.parkinglist, required this.index});

  final List<ParkingModel> parkinglist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainImage(parkinglist, index, context),
            sizedtwenty(context),
            mainTitle(parkinglist, index),
            sizedtwenty(context),
            subCategories('10AM to 12PM', Icons.watch_later, context),
            subCategories('${parkinglist[index].totalSpots} spots available',
                Icons.check_circle, context),
            subCategories(
                parkinglist[index].indoor
                    ? 'Indoor Parking'
                    : 'Outdoor Parking',
                parkinglist[index].indoor ? Icons.apartment : Icons.fence,
                context),
            subCategories(
                parkinglist[index].evCharge && parkinglist[index].carWash
                    ? 'Carwash, EV Charging, Security'
                    : parkinglist[index].carWash
                        ? 'Carwash, Security'
                        : parkinglist[index].evCharge
                            ? 'EV Charging, Security'
                            : 'Security',
                Icons.bolt,
                context),
            const Spacer(),
            ParkingButton(
              text: 'Book Parking',
              onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ChooseVehicle(
                      parkingList: parkinglist,
                      index: index,
                    );
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget mainImage(
    List<ParkingModel> parkinglist, int index, BuildContext context) {
  return Stack(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 220,
            width: double.maxFinite,
            child: Image.network(
              parkinglist[index].image,
              fit: BoxFit.cover,
            ),
          )),
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: white
          ))
    ],
  );
}

Widget mainTitle(List<ParkingModel> parkinglist, int index) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parkinglist[index].parkingName,
            style: KTextTheme.darkTextTheme.titleLarge,
          ),
          Text(parkinglist[index].locationName,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(150, 255, 255, 255)))
        ],
      ),
      const Spacer(),
      Icon(
        Icons.favorite_border_rounded,
        color: greenColor,
      )
    ],
  );
}

Widget subCategories(String text, IconData icon, BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 27,
          ),
          sizedwten(context),
          Text(
            text,
            style: const TextStyle(
                color: Color.fromARGB(150, 255, 255, 255),
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      sizedtwenty(context),
    ],
  );
}
