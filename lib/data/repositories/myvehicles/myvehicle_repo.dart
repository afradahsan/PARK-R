import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/errorhandling.dart';
import 'package:provider/provider.dart';

class MyVehicleRepo {
  void addVehicles({
    required BuildContext context,
    required String vehicleName,
    required String vehicleNumber,
    required String vehicleType,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, // Add the GlobalKey parameter
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint('addveh called');

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-vehicles'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'vehicleName': vehicleName,
          'vehicleNumber': vehicleNumber,
          'vehicleType': vehicleType,
        }),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Success: Your vehicle added!');
          showSnackbar(scaffoldMessengerKey, 'Vehicle Added'); // Use the GlobalKey here
          onSuccess(); // Calling the passed success callback
        },
      );
    } catch (e) {
      showSnackbar(scaffoldMessengerKey, 'Failed Adding Vehicle'); // Use the GlobalKey here
      debugPrint('Error: $e');
    }
  }

  Future<List<Vehicle>> getVehicles(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-vehicles'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
      );

      if (res.statusCode == 200) {
        List<dynamic> vehiclesJson = jsonDecode(res.body);
        debugPrint('Response JSON: $vehiclesJson');

        List<Vehicle> vehicles = vehiclesJson.map((json) {
          return Vehicle.fromJson(json);
        }).toList();

        return vehicles;
      } else {
        debugPrint('Failed to fetch vehicles: ${res.statusCode}');
        throw Exception('Failed to fetch vehicles: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching vehicles: $e');
      throw Exception('Error fetching vehicles: $e');
    }
  }

  void editVehicle({
    required BuildContext context,
    required String vehicleName,
    required String vehicleNumber,
    required String vehicleType,
    required String vehicleId,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, // Add the GlobalKey parameter
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint('editVeh Called');
      debugPrint('id: $vehicleId');

      http.Response res = await http.post(
        Uri.parse('$uri/api/edit-vehicles'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'vehicleId': vehicleId,
          'vehicleName': vehicleName,
          'vehicleNumber': vehicleNumber,
          'vehicleType': vehicleType,
        }),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Update Success!');
          showSnackbar(scaffoldMessengerKey, 'Update Success!'); // Use the GlobalKey here
          onSuccess(); // Calling the passed success callback
        }
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void deleteVehicle({
    required BuildContext context,
    required Vehicle vehicles,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, // Add the GlobalKey parameter
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      debugPrint('del veh called, ${vehicles.id}');
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-vehicle'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': vehicles.id}),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Res Body: ${res.body}');

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(scaffoldMessengerKey, 'Vehicle Deleted'); // Use the GlobalKey here
          onSuccess(); // Calling the passed success callback
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
      showSnackbar(scaffoldMessengerKey, 'Failed Deleting Vehicle'); // Use the GlobalKey here
    }
  }
}

void showSnackbar(GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, String text) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState;
  if (scaffoldMessenger != null) {
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
  } else {
    debugPrint("ScaffoldMessengerState is null. Unable to show Snackbar.");
  }
}