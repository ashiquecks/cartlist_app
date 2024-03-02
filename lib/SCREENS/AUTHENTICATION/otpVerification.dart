import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/textWidgets.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;
  const OTPVerification({super.key, required this.phoneNumber});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String? verificationCode;
  final pinController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 40,
    height: 45,
    textStyle: const TextStyle(
      fontSize: 15,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: colorPrimary),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: widgetSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: widgetSize.height / 4,
                  child: Image.asset(otpVerification),
                ),
                const SizedBox(height: 40),
                boldText(
                    labelText: "send OTP on " + widget.phoneNumber + " number"),
                const SizedBox(height: 40),
                SizedBox(
                  width: widgetSize.width / 1.3,
                  child: Pinput(
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    controller: pinController,
                    focusNode: _pinOTPCodeFocus,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: widgetSize.width / 1.5,
                  child: loginButton(
                    context: context,
                    buttonText: "VERIFY OTP",
                    buttonAction: () =>
                        Navigator.pushNamed(context, '/homeNavigation'),
                  ),
                ),
                const SizedBox(height: 40),
                appRichTextWidget(
                    textOne: "Didn't receive an OTP? ", textTwo: "Recent OTP"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
