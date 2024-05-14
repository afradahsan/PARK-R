import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class HourPickerSingleHour extends StatelessWidget {
  final double START_END_CIRCLE_RADIUS = 16;
  final double START_END_PERIOD_MARGIN = 12;

  final HourPickerHourState state;
  final String timeHeader;
  final String dateParam;
  final String dateTime;
  final bool hoursAvailability;

  const HourPickerSingleHour(
      this.state,
      this.timeHeader,
      this.dateParam,
      this.dateTime,
      this.hoursAvailability);

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = EdgeInsets.only(
        left: state == HourPickerHourState.START ? START_END_PERIOD_MARGIN : 0,
        right: state == HourPickerHourState.END ? START_END_PERIOD_MARGIN : 0,
        bottom: 0,
        top: 0,
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: whitet50,
        borderRadius: BorderRadius.only(
          topLeft: state == HourPickerHourState.START ? const Radius.circular(12) : const Radius.circular(0),
          bottomLeft: state == HourPickerHourState.START ? const Radius.circular(12) : const Radius.circular(0),
          topRight: state == HourPickerHourState.END ? Radius.circular(START_END_CIRCLE_RADIUS) : const Radius.circular(0),
          bottomRight: state == HourPickerHourState.END ? Radius.circular(START_END_CIRCLE_RADIUS) : const Radius.circular(0),
        )
      ),
      alignment: Alignment.center,
      child: Text(
        timeHeader,
        key: Key(
            'text_dayHour_${dateParam}_${dateTime}'),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            color: hoursAvailability
                ? greenColor
                : white),
      ),
    );
  }
}

enum HourPickerHourState {
  START,
  MIDDLE,
  END,
  EMPTY
}