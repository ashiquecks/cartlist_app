import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/PROVIDER/userLoginProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/otpVerification.dart';
import 'package:cartlist/SERVICE/loginUserApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController passControl = TextEditingController();
  String? phoneNumber;

  bool passwordShow = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool keybordAction = false;

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: widgetSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widgetSize.width / 1.5,
                    child: Image.asset(phoneVerification),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: IntlPhoneField(
                      showCursor: keybordAction,
                      readOnly: keybordAction,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (number) {
                        if (number!.completeNumber.isEmpty) {
                          return "Enter Your Phone Number";
                        }
                      },
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        setState(() {
                          phoneNumber = phone.completeNumber;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      showCursor: keybordAction,
                      readOnly: keybordAction,
                      controller: passControl,
                      obscureText: passwordShow,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordShow = false;
                            });
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                passwordShow = true;
                              });
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 8) {
                          return "password lenght has 8 charecters";
                        } else if (value.isEmpty) {
                          return "Enter Your Password";
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  loginButton(
                    context: context,
                    buttonText: "LOGIN",
                    buttonAction: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      final loginProvider = Provider.of<UserLoginProvider>(
                          context,
                          listen: false);

                      final response = await LoginUserservice.loginUserResponse(
                          userPassword: passControl.text,
                          userPhone: phoneNumber.toString());

                      print("LOGIN CALL");

                      if (response.message ==
                          "Unable to reach the internet! Ple ase try again in  a minutes or two") {
                        Navigator.pushNamed(context, '/lossConnection');
                      } else if (response.data == null) {
                        showAlertInternetWarningMessage(
                            message: "Invalid Credentials", context: context);
                      } else if (response.data!.message ==
                          "Invalid Credentials") {
                        print("FUNCTION2");
                        showAlertInternetWarningMessage(
                            message: "Invalid Credentials", context: context);
                      } else {
                        print("FUNCTION3");
                        getCategoryResponse(context: context);
                        getFavCategoryResponse(
                            context: context,
                            profileUserID: response.data!.userData.userId);
                        getStockProductResponse(
                            context: context,
                            profileUserID: response.data!.userData.userId);
                        getSponsorProductResponse(context: context);
                        getMainBannerResponse(context: context);
                        getSecondBannerResponse(context: context);
                        // showAlertDialogTwo(
                        //     context: context,
                        //     alertMessage: 'Registration Compleeted');

                        setUserCredentials(
                          userName: response.data!.userData.userName,
                          userPhone: response.data!.userData.phoneNumber,
                          userId: response.data!.userData.userId,
                          registerStatus: true,
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, '/homeNavigation');
                        setState(() {
                          keybordAction = true;
                        });

                        showAlertDialogTwo(
                          alertMessage: "Login Successfull",
                          context: context,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/registerUser');
                    },
                    child: appRichTextWidget(
                        textOne: "new user? ", textTwo: "Register Now"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
