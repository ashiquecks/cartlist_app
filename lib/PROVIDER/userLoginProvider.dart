import 'package:flutter/cupertino.dart';

class UserLoginProvider with ChangeNotifier {
  String? userID;
  String? userPhone;
  String? userPassword;
  String? userName;
  String? loginResponse;
  String? loginMessage;

  setUserID(String passUserID) {
    userID = passUserID;
    notifyListeners();
  }

  setUserPhone(String passUserPhone) {
    userPhone = passUserPhone;
    notifyListeners();
  }

  setUserPassword(String passUserPassword) {
    userPassword = passUserPassword;
    notifyListeners();
  }

  setUserName(String passUserName) {
    userName = passUserName;
    notifyListeners();
  }

  setLoginResponse(String passLoginResponse) {
    loginResponse = passLoginResponse;
    notifyListeners();
  }

  setLoginMessage(String passLoginMessage) {
    loginMessage = passLoginMessage;
    notifyListeners();
  }
}
