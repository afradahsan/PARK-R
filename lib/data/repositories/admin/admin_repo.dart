import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/errorhandling.dart';
import 'package:provider/provider.dart';

class AdminRepo {
  void addParking({
    required BuildContext context,
    required File image,
    required String parkingName,
    required String locationName,
    required String position,
    required int totalSpots,
    required int parkingFee,
    required bool indoor,
    required bool carWash,
    required bool evCharge,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint('addParking called');

      // Debug print for image path
      debugPrint('Image path: ${image.path}');

      final cloudinary = CloudinaryPublic('dmgdy68yf', 'bprgy909');
      // Initialize imageUrl with null
      String? imageUrl;

// Update imageUrl with the Cloudinary URL if available
      CloudinaryResponse imageres =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(image.path));
      if (imageres.secureUrl != null) {
        imageUrl = imageres.secureUrl!;
      }

// Construct ParkingModel with the updated imageUrl
      ParkingModel parkingModel = ParkingModel(
        image:
            imageUrl ?? '', // Use empty string as fallback if imageUrl is null
        parkingName: parkingName,
        locationName: locationName,
        position: position.toString(),
        totalSpots: totalSpots,
        parkingFee: parkingFee,
        indoor: indoor,
        carWash: carWash,
        evCharge: evCharge,
      );

      // Debug print for the JSON representation of parkingModel
      debugPrint('Parking model JSON: ${parkingModel.toJson()}');

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-parking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: parkingModel.toJson(),
      );

      // Debug print for the response
      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Success: Your Parking Lot is Live!');
          showSnackbar(context, 'Your Parking Lot is Live!');
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<List<ParkingModel>> fetchParkingLots(BuildContext context) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ParkingModel> parkingList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-parking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      debugPrint('status: ${res.statusCode.toString()}');
      debugPrint('${res.body}');

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              parkingList.add(
                  ParkingModel.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      debugPrint(e.toString());
      showSnackbar(context, e.toString());
    }
    return parkingList;
  }
}
