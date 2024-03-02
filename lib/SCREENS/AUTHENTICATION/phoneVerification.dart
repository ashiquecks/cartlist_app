import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/otpVerification.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';

import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  String? phoneNumber;

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
                  width: widgetSize.width / 2,
                  child: Image.asset(phoneVerification),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      setState(() {
                        phoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                ),
                loginButton(
                  context: context,
                  buttonText: "SEND OTP",
                  buttonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPVerification(
                          phoneNumber: phoneNumber.toString(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text("we will send you one time password"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
