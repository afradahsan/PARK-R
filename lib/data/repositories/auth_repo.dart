import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkr/data/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/presentation/widgets/auth/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/errorhandling.dart';

class AuthRepo {
  void signupUser(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required BuildContext context}) async {
    try {
      UserModel user = UserModel(
          id: '',
          name: name,
          email: email,
          phone: phone,
          password: password,
          type: '',
          token: ''
      );

    http.Response res = await http.post(Uri.parse('$uri/api/signup'),
    body: user.toJson(),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(res.body);

    httpErrorHandle(response: res, context: context, onSuccess: (){
      showSnackbar(context, 'Account Created Successfully!');
    });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<bool> checkUser({
  required String phoneNumber,
}) async {
  print('checkUser');
  try {
    final http.Response res = await http.post(
      Uri.parse('$uri/check-user'),
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
      return existingUser;
    } else {
      print('Error 201');
      return false;
    }
  } catch (error) {
    print('Error: $error');
    return false;
  }
}


}
