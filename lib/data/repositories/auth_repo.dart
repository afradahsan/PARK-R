import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkr/data/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/presentation/widgets/auth/snackbar.dart';
import 'package:parkr/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
    debugPrint('checkUser');
    try {
      final http.Response res = await http.post(
        Uri.parse('$uri/api/check-user'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phoneNumber}),
      );

      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(res.body);
        debugPrint('Data from response: $data');
        final bool existingUser = data['existingUser'];
        debugPrint('Existing User: $existingUser');
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

  Future<String> signinUser(BuildContext context,
  {required String phone,
  required String password}) async {
    try {
      final http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: json.encode({"phone": phone, "password": password}),
          headers: {'Content-Type': 'application/json'});
      debugPrint('Response status code: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        debugPrint('go to setuser');
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        await prefs.setString('auth-token', jsonDecode(res.body)['token']);
        return 'success';
        
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  void getUserData(BuildContext context) async{
    try{
      debugPrint('getuserdata called..');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');
      debugPrint('token: $token');
      if(token == null){
        debugPrint('token null');
        prefs.setString('auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenisValid'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      debugPrint('resp: $response');
      if(response==true){
        debugPrint('hello');
       http.Response userRes = await http.get(Uri.parse('$uri/'),
       headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'auth-token': token
       }
       );
        debugPrint('userres: ${userRes.body}');
       var userProvider = Provider.of<UserProvider>(context, listen: false);
       debugPrint('into setuserr');
       userProvider.setUser(userRes.body);
      }
    } catch (e) {
          debugPrint('Exception in getUserData: $e');
      // showSnackbar(context, e.toString());
    }
  } 
}
