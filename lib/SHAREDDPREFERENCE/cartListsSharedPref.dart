import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

SharedPreferences? addresspreference;

setUserCredentials({
  required String userName,
  required String userPhone,
  required String userId,
  required bool registerStatus,
}) async {
  preferences = await SharedPreferences.getInstance();

  preferences!.setString("UserName", userName);
  preferences!.setString("UserPhone", userPhone);
  preferences!.setString("userId", userId);
  preferences!.setBool("registerUser", registerStatus);
}

getUserCredentials() async {
  preferences = await SharedPreferences.getInstance();
  bool registerUser = preferences!.getBool("registerUser") ?? false;
  return registerUser;
}

void createAddressToShared({
  required BuildContext context,
  required String userHoseName,
  required String userLandMark,
  required String userPlace,
  required String userPostcode,
  required String userCity,
  required bool addressAdded,
}) async {
  addresspreference = await SharedPreferences.getInstance();

  addresspreference!.setString("UserHoseName", userHoseName);
  addresspreference!.setString("UserLandMark", userLandMark);
  addresspreference!.setString("UserPlace", userPlace);
  addresspreference!.setString("UserPostcode", userPostcode);
  addresspreference!.setString("UserCity", userCity);
  addresspreference!.setBool("AddressAdded", addressAdded);

  showAlertDialogTwo(alertMessage: "Your Address Has Saved", context: context);

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.popAndPushNamed(context, '/profileScreen');
  });
}

getAddressCredentials() async {
  addresspreference = await SharedPreferences.getInstance();
  bool addressFilled = addresspreference!.getBool("AddressAdded") ?? false;
  return addressFilled;
}

void conformAddressShare({
  required bool addressShare,
}) {
  addresspreference!.setBool("AddressShare", addressShare);
}

shareAddressWithShopList() async {
  addresspreference = await SharedPreferences.getInstance();
  bool addressShare = addresspreference!.getBool("AddressShare") ?? false;
  return addressShare;
}
