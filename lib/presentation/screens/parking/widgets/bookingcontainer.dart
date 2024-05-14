import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkr/data/models/bookingmodel.dart';
import 'package:parkr/presentation/screens/parking/viewticket.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class BookingContainer extends StatelessWidget {
  const BookingContainer(
      {super.key, required this.bookingList, required this.index});

  final List<BookingModel> bookingList;
  final int index;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(bookingList[index].startDate);
    String formattedDate = DateFormat("MMMM d").format(dateTime);

    String startTime = formatTime(bookingList[index].startTime);
    String endTime = formatTime(bookingList[index].endTime);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewTicket();
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(60, 255, 255, 255),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 90,
                height: 80,
                child: Image.asset(
                  'assets/mall-parking-image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            sizedwten(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingList[index].parkingLot,
                  style: KTextTheme.darkwhiteTextTheme.titleMedium,
                ),
                sizedfive(context),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: whitet200,
                    ),
                    sizedwfive(context),
                    Text(
                      formattedDate,
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 14),
                    ),
                  ],
                ),sizedfive(context),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 18,
                      color: whitet200,),
                    sizedwfive(context),
                    Text('$startTime - $endTime', style: KTextTheme.darkTextTheme.bodyMedium,)
                  ],
                ),
                sizedfive(context),
                Row(children: [
                  Image.asset('assets/wash-sponge-emoji.png', height: 18,),
                  sizedwfive(context),
                  Text('Washing Included', style: KTextTheme.darkTextTheme.bodyMedium)
                ],)
              ],
            )
          ],
        ),
      ),
    );
  }
}