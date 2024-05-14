import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/parking/paymentscreen.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/presentation/screens/parking/widgets/timerange/availability.dart';
import 'package:parkr/presentation/screens/parking/widgets/timerange/timerangepicker.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ChooseParking extends StatefulWidget {
  const ChooseParking(
      {super.key,
      required this.parkingname,
      required this.vehicleType,
      required this.index});

  final String parkingname;
  final String vehicleType;
  final int index;

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

  Availability availability = Availability(
      date: DateTime.now(),
      available: [
        01,
        02,
        03,
        04,
        05,
        06,
        07,
        08,
        09,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        19,
        20,
        21,
        22,
        23,
        24
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            const Spacer(flex: 5,),
            ParkingButton(
                text: 'Proceed',
                onpressed: () {
                  if(date != null && reachTime!=null && leaveTime!=null){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      parkingname: widget.parkingname,
                      startTime: reachTime!,
                      endTime: leaveTime!,
                      startDate: date.toString(),
                      endDate: date.toString(),
                      index: widget.index,
                    ),
                  ));} else {
                    showSnackbar(context, 'Please Choose Date & Time!');
                  }
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
        width: 160,
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
  return Flexible(
    child: TimeRangePickerDialog(
      availability,
      4,
      4,
      40,
      onTimeSelected: (startTime, endTime) {
        setState(() {
          reachTime = startTime;
          leaveTime = endTime;

          debugPrint('reach:$reachTime, $endTime');
        });
      },
    ),
  );
}


  // Widget selectTime() {
  //
  //   return Row(
  //     children: [
  //       GestureDetector(
  //         onTap: () async {
  //           reachTime = await showTimePicker(
  //             context: context,
  //             initialTime: TimeOfDay.now(),
  //             helpText: 'Choose Time',
  //           );
  //           if (reachTime != null) {
  //             setState(() {
  //               reachText = "${reachTime!.hour}:${reachTime!.minute}";
  //             });
  //           }
  //         },
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           height: 50,
  //           width: 170,
  //           decoration: BoxDecoration(
  //               color: whitet50, borderRadius: BorderRadius.circular(15)),
  //           child: Row(
  //             children: [
  //               Text(reachText),
  //               sizedwfive(context),
  //               Icon(
  //                 Icons.arrow_drop_down_outlined,
  //                 color: white,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       sizedwten(context),
  //       // if (leaveTime != null) {
  //       //   setState(() {
  //       //     leaveText = "${leaveTime!.hour}:${leaveTime!.minute}";
  //       //   });
  //       // }
  //       // child: Container(
  //       //   padding: const EdgeInsets.symmetric(horizontal: 15),
  //       //   height: 50,
  //       //   width: 170,
  //       //   decoration: BoxDecoration(
  //       //       color: whitet50, borderRadius: BorderRadius.circular(15)),
  //       //   child: Row(
  //       //     children: [
  //       //       Text(leaveText),
  //       //       sizedwfive(context),
  //       //       Icon(
  //       //         Icons.arrow_drop_down_outlined,
  //       //         color: white,
  //       //       )
  //       //     ],
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
}