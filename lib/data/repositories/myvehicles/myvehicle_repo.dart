import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
          body: jsonEncode(
              {'vehicleName': vehicleName, 'vehicleNumber': vehicleNumber,
              'vehicleType': vehicleType}));

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
}
