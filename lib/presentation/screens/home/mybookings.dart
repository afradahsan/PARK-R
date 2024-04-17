import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/bookings_bloc/bookings_bloc.dart';
import 'package:parkr/presentation/screens/home/widgets/parkinglotcontainer.dart';
import 'package:parkr/presentation/screens/parking/widgets/bookingcontainer.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My Bookings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sizedtwenty(context),
            BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) {
                if (state is BookingsInitial) {
                  context.read<BookingsBloc>().add(BookingdetailsEvent(context: context));
                  return CircularProgressIndicator(
                    color: white,
                  );
                } else if (state is BookingsLoadingState) {
                  return CircularProgressIndicator(
                    color: greenColor,
                  );
                } else if (state is BookingSuccessState) {
                  return BookingContainer(bookingList: state.bookingList, index: 0);
                } else if (state is BookingErrorState) {
                  return const Text('Error: Failed to load parking details');
                } else {
                  return const Text('Unknown state');
                }
              },
            )
          ],
        ),
      )),
    );
  }
}