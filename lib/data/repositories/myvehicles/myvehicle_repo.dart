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
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint('addveh called');

      http.Response res = await http.post(Uri.parse('$uri/api/add-vehicles'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'vehicleName': vehicleName,
            'vehicleNumber': vehicleNumber,
            'vehicleType': vehicleType
          }));

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          debugPrint('Success: Your vehicle added!');
          showSnackbar(context, 'Vehicle Added');
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
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

  
  // Future<Vehicle> fetchVehicleByID(String id) async {
  //   final response = await http.get(
  //     Uri.parse(
  //         '$uri/api/get-vehicles/$id'),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(response.body);
  //     return Vehicle.fromJson(responseData);
  //   } else if (response.statusCode == 404) {
  //     throw Exception('Vehicle not found');
  //   } else {
  //   throw Exception('Failed to fetch vehicle details');
  //   }
  // }

  void editVehicle(
      {required BuildContext context,
      required String vehicleName,
      required String vehicleNumber,
      required String vehicleType,
      required String vehicleId}) async {
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
          Navigator.of(context).pop();
          showSnackbar(context, 'Update Success!');
        }
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void deleteVehicle({
    required BuildContext context,
    required Vehicle vehicles,
    required VoidCallback onSuccess
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
          onSuccess();
        },
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
