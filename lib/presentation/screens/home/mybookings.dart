import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/bookings_bloc/bookings_bloc.dart';
import 'package:parkr/presentation/screens/parking/widgets/bookingcontainer.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';
import 'package:shimmer/shimmer.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              BlocBuilder<BookingsBloc, BookingsState>(
                builder: (context, state) {
                  if (state is BookingsInitial) {
                    context
                        .read<BookingsBloc>()
                        .add(BookingdetailsEvent(context: context));
                    return ListView.separated(
                      shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 130,
                              width: screenW(context),
                              decoration: BoxDecoration(
                                  color: whitet50,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return sizedten(context);
                        },
                        itemCount: 6);
                  } else if (state is BookingsLoadingState) {
                    return CircularProgressIndicator(
                      color: greenColor,
                    );
                  } else if (state is BookingSuccessState) {
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BookingContainer(
                              bookingList: state.bookingList, index: index);
                        },
                        separatorBuilder: (context, index) {
                          return sizedten(context);
                        },
                        itemCount: state.bookingList.length);
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
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Text(
        'My Bookings',
        style: KTextTheme.darkTextTheme.headlineMedium,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: greenColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
      forceMaterialTransparency: true,
    );
  }
}
