import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkr/data/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/presentation/screens/navscreens.dart/bottomnav.dart';
import 'package:parkr/presentation/widgets/auth/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/errorhandling.dart';

class AuthRepo {
  Future<String> signupUser(
      {required UserModel usermodel, BuildContext? context}) async {
    try {
      UserModel user = UserModel(
          id: '',
          name: usermodel.name,
          email: usermodel.email,
          phone: usermodel.phone,
          password: usermodel.password,
          type: '',
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      debugPrint(res.body);
      debugPrint('${res.statusCode}');
      if (res.statusCode == 201) {
        return 'success';
      }
      if (res.statusCode == 400) {
        return 'Try Again';
      }
      return 'error';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  Future<String> checkUser({
    required String phoneNumber,
  }) async {
    print('checkUser');
    try {
      final http.Response res = await http.post(
        Uri.parse('$uri/api/check-user'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phoneNumber}),
      );

      print('Response status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(res.body);
        print('Data from response: $data');
        final bool existingUser = data['existingUser'];
        print('Existing User: $existingUser');
        if (existingUser) {
          return 'exists';
        } else {
          return 'new user';
        }
      } else {
        return 'error';
      }
    } catch (error) {
      print('Error: $error');
      return 'HTTP Error';
    }
  }

  Future<String> signinUser(
      {required String phone,
      required String password}) async {
    try {
      final http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: json.encode({"phone": phone, "password": password}),
          headers: {'Content-Type': 'application/json'});
      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        return 'success';
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }
}
