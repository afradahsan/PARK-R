import 'package:flutter/material.dart';
import 'package:parkr/data/models/bookingmodel.dart'; // Import your BookingModel
import 'package:parkr/data/models/parkingmodel.dart'; // Import your ParkingModel
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/bookings/booking_repo.dart';

class OwnerRevenue extends StatefulWidget {
  const OwnerRevenue({Key? key}) : super(key: key);

  @override
  _OwnerRevenueState createState() => _OwnerRevenueState();
}

class _OwnerRevenueState extends State<OwnerRevenue> {
  BookingRepo _bookingRepo = BookingRepo(); // Instance of your BookingRepo
  AdminRepo _parkingRepo = AdminRepo(); // Instance of your ParkingRepo
  int totalRevenue = 0;

  @override
  void initState() {
    super.initState();
    fetchTotalRevenue();
  }

  // Fetch total revenue for all parking lots associated with the owner
  void fetchTotalRevenue() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String ownerId = userProvider.user.id;
      List<ParkingModel> parkingLots = await _parkingRepo.fetchParkingLotsForOwner(context, ownerId); // Fetch all parking lots associated with the owner
      int total = 0;
      for (var parkingLot in parkingLots) {
        List<BookingModel> bookings = await _bookingRepo.fetchBookingsForParkingLot(context, parkingLot.id!); // Fetch bookings for each parking lot
        for (var booking in bookings) {
          total += booking.totalPrice;
        }
      }
      setState(() {
        totalRevenue = total;
      });
    } catch (e) {
      print('Error fetching total revenue: $e');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Revenue from All Parking Lots:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '₹ $totalRevenue',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
