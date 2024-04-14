import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubit/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/business_logic/cubit/wash/wash_cubit.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/bookings/booking_repo.dart';
import 'package:parkr/data/repositories/payment/razorpay.dart';
import 'package:parkr/presentation/screens/parking/success.dart';
import 'package:parkr/presentation/screens/parking/widgets/coupons.dart';
import 'package:parkr/presentation/screens/parking/widgets/parkingbutton.dart';
import 'package:parkr/presentation/screens/parking/widgets/paymentmethod.dart';
import 'package:parkr/presentation/screens/parking/widgets/paymenttotal.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/user_provider.dart';
import '../../../utils/themes.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key,
      required this.parkingid,
      required this.startTime,
      required this.endTime,
      required this.startDate,
      required this.endDate,
      required this.parkingList});

  final String parkingid;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final List<ParkingModel> parkingList;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.user;

    final wash = BlocProvider.of<WashCubit>(context).state;

    final vehIndex = BlocProvider.of<SelectvehindexCubit>(context).state;

    final myvehiclesState = BlocProvider.of<MyvehiclesBloc>(context).state;
    String vehNumber = '';
    if (myvehiclesState is MyVehiclesSuccess) {
      final myvehiclesList = myvehiclesState.myVehicles;
      vehNumber = myvehiclesList.isNotEmpty
          ? myvehiclesList[vehIndex].vehicleNumber
          : '';
    }

    Future<void> bookParking() async {
      await BookingRepo().bookParking(
          user: currentUser.id,
          parkingLot: parkingid,
          startTime: startTime,
          endTime: endTime,
          startDate: startDate,
          endDate: endDate,
          vehicleNumber: vehNumber,
          qrCodeData: 'qrCodeData',
          status: 'confirmed',
          paymentStatus: 'paid',
          totalPrice: 100,
          context: context);
    }

    return Scaffold(
      appBar: appbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Amount',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const TotalPayContainer(),
            sizedtwenty(context),
            Text('Choose Payment Method',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const PayMethodContainer(),
            sizedtwenty(context),
            Text('Offers & Benefits',
                style: KTextTheme.darkwhiteTextTheme.titleMedium),
            sizedten(context),
            const CouponsContainer(),
            const Spacer(),
            ParkingButton(
                text: 'Tap to Pay',
                onpressed: () async {
                  await RazorPayService.checkoutOrder(bookin, onSuccess: (response){
                    bookParking();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SuccessScreen();
                    },
                  ));
                  }, onFailure: (response){
                    debugPrint('payment failed');
                  });
                })
          ],
        ),
      )),
    );
  }
}

AppBar appbar() {
  return AppBar(
    title: Text(
      'Confirmation',
      style: KTextTheme.darkTextTheme.titleLarge,
    ),
    iconTheme: IconThemeData(color: greenColor),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}