import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingLotContainer extends StatelessWidget {
  const ParkingLotContainer({super.key, required this.parkinglotList, required this.index});

  final List<ParkingModel> parkinglotList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(60, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(width: 75, height: 75 ,
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(10)
              ),child: Image.network('${parkinglotList![index].image}', fit: BoxFit.cover,), ),
              sizedwten(context), 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(parkinglotList![index].parkingName, style: KTextTheme.darkTextTheme.titleMedium,),
                Text(parkinglotList![index].locationName, style: TextStyle(color: const Color.fromARGB(130, 255, 255, 255), fontSize: 14),),
                Spacer(),
                Row(children: [
                  Image.asset(
                    'assets/Rupee3x.png', height: 30,
                  ),
                  Text('${parkinglotList![index].parkingFee.toString()}/hr')
                ],)
              ],)
            ],),
          );
  }
}