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
}
