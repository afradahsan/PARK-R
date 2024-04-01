// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
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

      debugPrint('Image path: ${image.path}');

      final cloudinary = CloudinaryPublic('dmgdy68yf', 'bprgy909');
      String? imageUrl;

      CloudinaryResponse imageres =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(image.path));
      if (imageres.secureUrl != null) {
        imageUrl = imageres.secureUrl!;
      }

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

      debugPrint('Parking model JSON: ${parkingModel.toJson()}');

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-parking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: parkingModel.toJson(),
      );

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

  Future<ParkingModel> fetchParkingByID(String id) async {
    final response = await http.get(
      Uri.parse(
          '$uri/admin/get-parking/$id'), // Include the ID in the endpoint URL
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // No need to search for the parking lot, as we are fetching by ID directly
      return ParkingModel.fromJson(jsonEncode(responseData));
    } else if (response.statusCode == 404) {
      throw Exception('Parking lot not found');
    } else {
      throw Exception('Failed to fetch parking details');
    }
  }

  void editParking({
    required BuildContext context,
    required String id,
    File? image,
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
      debugPrint('editParking called');

      String? imageUrl;

      if (image != null) {
        debugPrint('Image path: ${image.path}');

        final cloudinary = CloudinaryPublic('dmgdy68yf', 'bprgy909');

        CloudinaryResponse imageres =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(image.path));
        if (imageres.secureUrl != null) {
          imageUrl = imageres.secureUrl!;
        }
      }

      debugPrint('id: $id');
      final existingParkingDetails = await fetchParkingByID(id);

      // Construct the updated parking model
      ParkingModel parkingModel = ParkingModel(
        image: imageUrl ??
            existingParkingDetails
                .image, // Use the new image URL if available, otherwise use existing image URL
        parkingName: parkingName,
        locationName: locationName,
        position: position.toString(),
        totalSpots: totalSpots,
        parkingFee: parkingFee,
        indoor: indoor,
        carWash: carWash,
        evCharge: evCharge,
      );

      debugPrint('Parking model JSON: ${parkingModel.toJson()}');

      http.Response res = await http.post(
        Uri.parse('$uri/admin/edit-parking/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: parkingModel.toJson(),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Success: Your Parking Lot is updated!');
          Navigator.of(context).pop();
          showSnackbar(context, 'Your Parking Lot is updated!');
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void deleteParking({
    required BuildContext context,
    required ParkingModel parkingModel,
    required VoidCallback onSuccess
  }) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-parking'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': parkingModel.id}),
      );

      debugPrint('Response status code: ${res.statusCode}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}