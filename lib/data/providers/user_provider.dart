import 'package:flutter/material.dart';
import 'package:parkr/data/models/usermodel.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: '',
    name: '',
    email: '',
    phone: '',
    password: '',
    type: '',
    token: ''
  );

  UserModel get user => _user;

  void setUser(String user) {
    debugPrint('at setuser');
    _user = UserModel.fromJson(user);
    debugPrint('_user: $_user');
    notifyListeners();
  }
}