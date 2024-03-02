import 'dart:async';
import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  String? profileUserID;

  void getSharePrefData() {
    setState(() {
      profileUserID = preferences!.getString("userId");
    });
  }

  void splashTimer() async {
    addresspreference = await SharedPreferences.getInstance();
    addresspreference!.setString('dowloadVersion', '0.1');
    Timer(const Duration(seconds: 3), () async {
      if (await getUserCredentials() == true) {
        getSharePrefData();

        getCategoryResponse(context: context);
        getFavCategoryResponse(
            context: context, profileUserID: profileUserID.toString());
        getStockProductResponse(
            context: context, profileUserID: profileUserID.toString());
        getSponsorProductResponse(context: context);
        getMainBannerResponse(context: context);
        getSecondBannerResponse(context: context);
        Navigator.pushNamed(context, '/homeNavigation');
      } else {
        addresspreference!.setString('dowloadVersion', '0.1');
        await Navigator.pushNamed(context, '/loginUser');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: widgetSize.width / 1.8,
          child: Image.asset(
            splashLogo,
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "Build version: 1.1.0",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
