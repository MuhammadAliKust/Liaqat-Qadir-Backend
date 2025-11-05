import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _model = UserModel();

  void setUser(UserModel model) {
    _model = model;
    notifyListeners();
  }

  UserModel getUser() => _model;
}
