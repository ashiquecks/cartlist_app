import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  String? profileUserName;
  String? profileUserPhone;
  String? profileUserID;

  //ADDRESS SHARED PREFERENCE

  String? addressHouseName;
  String? addressLandMark;
  String? addressPlace;
  String? addressPostCode;
  String? addressCity;

  bool? addressShareConfirm;

  void getSharePrefData() {
    setState(() {
      profileUserName = preferences!.getString("UserName");
      profileUserPhone = preferences!.getString("UserPhone");
      profileUserID = preferences!.getString("userId");

      //ADDRESS SHARED PREFERENCE

      addressHouseName = addresspreference!.getString("UserHoseName");
      addressLandMark = addresspreference!.getString("UserLandMark");
      addressPlace = addresspreference!.getString("UserPlace");
      addressPostCode = addresspreference!.getString("UserPostcode");
      addressCity = addresspreference!.getString("UserCity");

      //ADDRESS SHARED CONFIRMATION

      addressShareConfirm = addresspreference!.getBool("AddressShare");
    });
  }

  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      (profileUserName![0]),
                      style: const TextStyle(fontSize: 20, color: colorWhite),
                    ),
                  ),
                  title: Text(profileUserName!),
                  subtitle: Text(profileUserPhone!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addressHouseName == null
                        ? OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/addAddress');
                            },
                            child: const Text('ADD YOUR ADDRESS'),
                          )
                        : OutlinedButton(
                            onPressed: () {
                              showAlertDialogWarning(
                                context: context,
                                confirmAction: () async {
                                  await addresspreference!
                                      .remove('UserHoseName');
                                  await addresspreference!
                                      .remove('UserLandMark');
                                  await addresspreference!.remove('UserPlace');
                                  await addresspreference!
                                      .remove('UserPostcode');
                                  await addresspreference!.remove('UserCity');
                                  Navigator.popAndPushNamed(
                                      context, '/profileScreen');
                                },
                                messageText: "Confirm Delete Your Address",
                                confirmButtonText: 'Delete',
                              );
                            },
                            child: const Text('DELETE ADDRESS'),
                          ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('PROFILE SETTINGS'),
                    ),
                  ],
                ),
              ),
              Card(
                child: CheckboxListTile(
                  title: Text("share your address with your shoping list"),
                  value: addressShareConfirm ?? false,
                  onChanged: (newValue) {
                    setState(() {
                      addressShareConfirm = newValue;
                      if (newValue == true) {
                        conformAddressShare(addressShare: true);
                      } else {
                        conformAddressShare(addressShare: false);
                      }
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      normalTextWithPadding(
                          labelText:
                              addressHouseName.toString() ?? "ADD Hose Name"),
                      normalTextWithPadding(
                          labelText:
                              addressLandMark.toString() ?? "ADD Hose Name"),
                      Row(
                        children: [
                          normalTextWithPadding(
                              labelText:
                                  addressPlace.toString() ?? "ADD Hose Name"),
                          const SizedBox(width: 10),
                          normalTextWithPadding(
                              labelText: addressPostCode.toString() ??
                                  "ADD Hose Name"),
                        ],
                      ),
                      Row(
                        children: [
                          normalTextWithPadding(
                              labelText:
                                  addressCity.toString() ?? "ADD Hose Name"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5),
              //   child: Image.asset(oneMillion),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
