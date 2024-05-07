// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/data/models/bookingmodel.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/errorhandling.dart';
import 'package:provider/provider.dart';

class BookingRepo {
  Future<void> bookParking(
      {required BookingModel bookingmodel,
      required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      debugPrint('bookparking called');
      debugPrint('startime: ${bookingmodel.startTime}');

      final bookingModel = BookingModel(
          user: bookingmodel.user,
          parkingLot: bookingmodel.parkingLot,
          startTime: bookingmodel.startTime,
          endTime: bookingmodel.endTime,
          startDate: bookingmodel.startDate,
          endDate: bookingmodel.endDate,
          vehicleNumber: bookingmodel.vehicleNumber,
          qrCodeData: bookingmodel.qrCodeData,
          status: bookingmodel.status,
          paymentStatus: bookingmodel.paymentStatus,
          totalPrice: bookingmodel.totalPrice);

      http.Response res = await http.post(
        Uri.parse('$uri/api/book-parking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: bookingModel.toJson(),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Booking success!');
          showSnackbar(context, 'Succcessfully booked!');
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  Future<List<BookingModel>> fetchBookings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BookingModel> bookingList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-booking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token
        },
      );

      debugPrint('statuscode: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('res: ${response.body}');
        final List<dynamic> responseData = jsonDecode(response.body);
        bookingList =
            responseData.map((data) => BookingModel.fromMap(data)).toList();
        debugPrint('Booking list: $bookingList');
      } else {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      showSnackbar(context, 'Error fetching bookings: $e');
    }

    return bookingList;
  }

  Future<List<BookingModel>> fetchBookingsForParkingLot(
      BuildContext context, String parkingLotId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BookingModel> bookingList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-booking/$parkingLotId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token
        },
      );

      debugPrint('statuscode: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('res: ${response.body}');
        final List<dynamic> responseData = jsonDecode(response.body);
        bookingList =
            responseData.map((data) => BookingModel.fromMap(data)).toList();
        debugPrint('Booking list: $bookingList');
      } else {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      showSnackbar(context, 'Error fetching bookings: $e');
    }

    return bookingList;
  }
}
