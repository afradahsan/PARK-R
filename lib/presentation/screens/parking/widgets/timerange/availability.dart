import 'package:intl/intl.dart';
import 'hour_availability.dart';

class Availability {
  DateTime date;
  late int reservationFrom;
  late int reservationTo;
  List<int> available;

  int? periodStartIndex;
  int? periodEndIndex;

  Availability({
    required this.date,
    required this.available,
  }) {
    final now = DateTime.now();
    reservationFrom = now.hour;
    reservationTo = 24;
  }


  List<HourAvailability> get hours {
    final now = DateTime.now();
    List<HourAvailability> list = [];
    for (var i = reservationFrom; i <= reservationTo; i++) {
      String time = DateTime(now.year, now.month, now.day, i, 0).time;
      list.add(HourAvailability(i, time, _specifyAvailability(i)));
    }
    return list;
  }

  bool _specifyAvailability(int i) =>
      available.contains(i) ||
          (i == reservationTo &&
              available.isNotEmpty &&
              available.last == (reservationTo - 1));
}

extension DateTimeFormat on DateTime {
  String get param => DateFormat('yyyy-MM-dd').format(this);
  String get time => DateFormat('hh:mm a').format(this);
}