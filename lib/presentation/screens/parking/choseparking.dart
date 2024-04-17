import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/parking/paymentscreen.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseParking extends StatefulWidget {
  const ChooseParking({super.key, required this.parkingname, required this.vehicleNumber, required this.parkingList});

  final String parkingname;
  final String vehicleNumber;
  final List<ParkingModel> parkingList;

  @override
  State<ChooseParking> createState() => _ChooseParkingState();
}

class _ChooseParkingState extends State<ChooseParking> {
  TimeOfDay? reachTime;
  TimeOfDay? leaveTime;
  DateTime? date;
  String reachText = 'Reaching Time';
  String leaveText = 'Leaving Time';
  String dateText = 'Select Date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Date:',
              style: KTextTheme.darkwhiteTextTheme.titleMedium,
            ),
            sizedfive(context),
            selectDate(),
            sizedten(context),
            Text(
              'Choose Timing:',
              style: KTextTheme.darkwhiteTextTheme.titleMedium,
            ),
            sizedten(context),
            selectTime(),
            const Spacer(),
            ParkingButton(text: 'Proceed', onpressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(parkingname: widget.parkingname, startTime: reachTime.toString(), endTime: leaveTime.toString(), startDate: date.toString(), endDate: date.toString(), parkingList: widget.parkingList,),));
            })
          ],
        ),
      )),
    );
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

  Widget selectDate() {
    return GestureDetector(
      onTap: () async {
        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100, 12, 31));
        if (date != null) {
          setState(() {
            dateText = date!.toLocal().toString().split(" ")[0];
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: whitet50, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: greenColor,
            ),
            sizedwten(context),
            Text(dateText),
          ],
        ),
      ),
    );
  }

  Widget selectTime() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            reachTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Choose Time',
            );
            if (reachTime != null) {
              setState(() {
                reachText = "${reachTime!.hour}:${reachTime!.minute}";
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            width: 170,
            decoration: BoxDecoration(
                color: whitet50, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Text(reachText),
                sizedwfive(context),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: white,
                )
              ],
            ),
          ),
        ),
        sizedwten(context),
        GestureDetector(
          onTap: () async {
            leaveTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                helpText: 'Choose Time');
            if (leaveTime != null) {
              setState(() {
                leaveText = "${leaveTime!.hour}:${leaveTime!.minute}";
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            width: 170,
            decoration: BoxDecoration(
                color: whitet50, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Text(leaveText),
                sizedwfive(context),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}