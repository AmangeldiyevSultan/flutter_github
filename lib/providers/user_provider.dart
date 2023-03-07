import 'package:flutter/cupertino.dart';
import 'package:flutter_github/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;

  // set UserModel
  void setUser(
    UserModel user,
  ) {
    _userModel = user;
    notifyListeners();
  }
}
