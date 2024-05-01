import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parkr/business_logic/bookings_bloc/bookings_bloc.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/parking/widgets/tickettestwidget.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';
import 'package:provider/provider.dart';

class ViewTicket extends StatelessWidget {
  const ViewTicket({super.key});

  @override
  Widget build(BuildContext context) {
    
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String username = userProvider.user.name;
    final String phoneNo = userProvider.user.phone;
    debugPrint("hello $username");
    debugPrint(phoneNo);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ticket Details',
                style: KTextTheme.darkTextTheme.titleLarge,
              ),
              sizedten(context),
              BlocBuilder<BookingsBloc, BookingsState>(
                  builder: (context, state) {
                if (state is BookingsInitial) {
                  context
                      .read<BookingsBloc>()
                      .add(BookingdetailsEvent(context: context));
                  return CircularProgressIndicator(
                    color: white,
                  );
                } else if (state is BookingErrorState) {
                  return const Text('Error: Failed to load parking details');
                } else if (state is BookingSuccessState) {
                  String startTime = formatTime(state
                      .bookingList[state.bookingList.length - 1].startTime);
                  String endTime = formatTime(
                      state.bookingList[state.bookingList.length - 1].endTime);

                  return Container(
                    padding: const EdgeInsets.all(20),
                    height: 550,
                    width: 300,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Image.asset(
                              'assets/An-example-of-QR-code.png',
                              height: 150,
                            ),
                          ),
                        ),
                        const Text('asdfghjklpoiuytrewqzxcvbnmiuytrrr',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                                decorationColor: Colors.black,
                                color: Colors.transparent)),
                        sizedtwenty(context),
                        TicketTest(title: 'Full Name', content: username),
                        sizedten(context),
                        TicketTest(
                            title: 'Vehicle Number',
                            content: state
                                .bookingList[state.bookingList.length - 1]
                                .vehicleNumber),
                        sizedten(context),
                        TicketTest(
                            title: 'Time', content: '$startTime to $endTime'),
                        sizedten(context),
                        TicketTest(
                            title: 'Location',
                            content: state
                                .bookingList[state.bookingList.length - 1]
                                .parkingLot),
                        sizedtwenty(context),
                        TicketTest(title: 'Phone Number', content: phoneNo),
                        sizedten(context),
                        Text(
                          ' Washing Included',
                          style: KTextTheme.lightTextTheme.labelLarge,
                        )
                      ],
                    ),
                  );
                } else {
                  return const Text('Error: Failed to load parking details');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
