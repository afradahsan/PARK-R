import 'package:flutter/material.dart';
import 'package:parkr/data/models/bookingmodel.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/data/repositories/bookings/booking_repo.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';
import 'package:provider/provider.dart';

class AdminRevenue extends StatefulWidget {
  const AdminRevenue({super.key});

  @override
  State<AdminRevenue> createState() => _AdminRevenueState();
}

class _AdminRevenueState extends State<AdminRevenue> {
  BookingRepo _bookingRepo = BookingRepo();
  AdminRepo _parkingRepo = AdminRepo();
  Map<String, int> parkingLotRevenues = {};
  int totalRevenue = 0;
  Map<String, int> numbooking = {};

  @override
  void initState() {
    super.initState();
    fetchParkingLotRevenues();
  }

  void fetchParkingLotRevenues() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String ownerId = userProvider.user.id;
      List<ParkingModel> parkingLots =
          await _parkingRepo.fetchParkingLotsForOwner(context, ownerId);
      int total = 0;
      for (var parkingLot in parkingLots) {
        List<BookingModel> bookings = await _bookingRepo
            .fetchBookingsForParkingLot(context, parkingLot.parkingName);

        int numBooking = 0;
        int revenue = 0;
        for (var booking in bookings) {
          revenue += booking.totalPrice;
          numBooking++;
        }

        total += revenue;
        parkingLotRevenues[parkingLot.parkingName] = revenue;
        numbooking[parkingLot.parkingName] = numBooking;
      }

      setState(() {
        totalRevenue = total; // Update total revenue
      });
    } catch (e) {
      print('Error fetching parking lot revenues: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Revenue',
          style: TextStyle(color: greenColor, fontSize: 22),
        ),
        backgroundColor: darkbgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: whitet50, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('T O T A L   I N C O M E',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: white)),
                    Text(
                      '₹$totalRevenue.00',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              // const Text(
              //   'Revenue from Each Parking Lot:',
              //   style: TextStyle(fontSize: 18),
              // ),
              const SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: parkingLotRevenues.length,
                  itemBuilder: (context, index) {
                    String parkingLotName =
                        parkingLotRevenues.keys.elementAt(index);
                    int revenue = parkingLotRevenues.values.elementAt(index);
                    int num = numbooking.values.elementAt(index);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parkingLotName,
                          style: KTextTheme.darkTextTheme.titleMedium,
                        ),
                        sizedfive(context),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 90,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: whitet50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(248, 191, 73, 1),
                                          Color.fromRGBO(221, 126, 48, 1)
                                        ])),
                                    child: Icon(
                                      Icons.payments_outlined,
                                      color: whitet200,
                                      size: 10,
                                    ),
                                  ),
                                  sizedwten(context),
                                  Text(
                                    '₹$revenue.00',
                                    style: KTextTheme.darkTextTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              sizedten(context),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(248, 191, 73, 1),
                                          Color.fromRGBO(221, 126, 48, 1)
                                        ])),
                                    child: Icon(
                                      Icons.confirmation_number_rounded,
                                      color: whitet200,
                                      size: 10,
                                    ),
                                  ),
                                  sizedwten(context),
                                  Text(
                                    '$num',
                                    style: KTextTheme.darkTextTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        sizedten(context)
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
