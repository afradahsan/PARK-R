import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/business_logic/cubits/totalprice_cubit/totalprice_cubit.dart';
import 'package:parkr/business_logic/cubits/wash/wash_cubit.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/data/models/bookingmodel.dart';
import 'package:parkr/data/repositories/bookings/booking_repo.dart';
import 'package:parkr/data/repositories/payment/razorpay.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/parking/successscreen.dart';
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
  const PaymentScreen({
    super.key,
    required this.parkingname,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.index,
  });

  final String parkingname;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String startDate;
  final String endDate;
  final int index;

  @override
  Widget build(BuildContext context) {
    debugPrint('rea - $startTime');
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.user;

    final wash = BlocProvider.of<WashCubit>(context).state;

    int totalPrice = 0;

    void updateTotalPrice(int price) {
      totalPrice = price;
    }

    final vehIndex = BlocProvider.of<SelectvehindexCubit>(context).state;

    final myvehiclesState = BlocProvider.of<MyvehiclesBloc>(context).state;
    String vehNumber = '';
    String vehicleType = '';

    if (myvehiclesState is MyVehiclesSuccess) {
      final myvehiclesList = myvehiclesState.myVehicles;
      vehNumber = myvehiclesList.isNotEmpty
          ? myvehiclesList[vehIndex].vehicleNumber
          : '';
      vehicleType =
          myvehiclesList.isNotEmpty ? myvehiclesList[vehIndex].vehicleType : '';
    }

    Future<void> bookParking(BookingModel bookingModel) async {
      await BookingRepo()
          .bookParking(bookingmodel: bookingModel, context: context);
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
            TotalPayContainer(
              index: index,
              vehicleType: vehicleType,
              wash: wash,
              startTime: startTime,
              endTime: endTime,
            ),
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
                debugPrint(
                    'totaall: ${BlocProvider.of<TotalpriceCubit>(context).state.toString()}');
                debugPrint('time: $startTime');
                BookingModel bookingModel = BookingModel(
                  user: currentUser.id,
                  parkingLot: parkingname,
                  startTime: startTime.toString(),
                  endTime: endTime.toString(),
                  startDate: startDate,
                  endDate: endDate,
                  vehicleNumber: vehNumber,
                  qrCodeData: 'qrCodeData',
                  status: 'confirmed',
                  paymentStatus: 'paid',
                  totalPrice: BlocProvider.of<TotalpriceCubit>(context).state,
                );

                await RazorPayService.checkoutOrder(
                  bookingModel,
                  onSuccess: (response) {
                    bookParking(bookingModel);
                    Navigator.popUntil(
                        context, ModalRoute.withName('/parkinglots'));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const SuccessScreen();
                      },
                    ));
                  },
                  onFailure: (response) {
                    showSnackbar(context, 'Payment Failed');
                    debugPrint('payment failed');
                  },
                );
              },
            )
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
