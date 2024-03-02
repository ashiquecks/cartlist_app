import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SERVICE/createUserApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool keybordAction = false;
  String? phoneNumber;

  bool passwordShow = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cnUser = TextEditingController();
  TextEditingController cnPassword = TextEditingController();
  TextEditingController cnSecondPassword = TextEditingController();

  String? userID1,
      userID2,
      userID3,
      userID4,
      userID5,
      userID6,
      userID7,
      userID8,
      userID9,
      userID10,
      userID11,
      userID12,
      userID13,
      userID14,
      userID15,
      userID16,
      userID17,
      userID18;

  void genarateUserID() {
    setState(() {
      userID1 = phoneNumber![1];
      userID2 = phoneNumber![2];
      userID3 = phoneNumber![3];
      userID4 = phoneNumber![4];
      userID5 = phoneNumber![5];
      userID6 = phoneNumber![6];
      userID7 = phoneNumber![7];
      userID8 = phoneNumber![8];
      userID9 = phoneNumber![9];
      userID10 = phoneNumber![10];
      userID11 = phoneNumber![11];
      userID12 = phoneNumber![10];
      userID13 = cnPassword.text[0];
      userID14 = cnPassword.text[1];
      userID15 = cnPassword.text[2];
      userID16 = cnUser.text[0];
      userID17 = cnUser.text[1];
      userID18 = cnUser.text[2];
    });
  }

  String? theUniqueID;

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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                      ],
                      showCursor: keybordAction,
                      readOnly: keybordAction,
                      controller: cnUser,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Valid User Name";
                        }
                      }),
                    ),
                  ),
                  const SizedBox(height: 25),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[0-9a-zA-Z]"),
                        ),
                      ],
                      showCursor: keybordAction,
                      readOnly: keybordAction,
                      controller: cnPassword,
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
                          return "Enter Valid Password";
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  loginButton(
                    context: context,
                    buttonText: "REGISTER",
                    buttonAction: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      genarateUserID();
                      showAlertDialogOne(context: context);
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          keybordAction = true;
                          theUniqueID = userID1.toString() +
                              userID2.toString() +
                              userID3.toString() +
                              userID4.toString() +
                              userID5.toString() +
                              userID6.toString() +
                              userID7.toString() +
                              userID8.toString() +
                              userID9.toString() +
                              userID10.toString() +
                              userID11.toString() +
                              userID12.toString() +
                              userID13.toString() +
                              userID14.toString() +
                              userID15.toString() +
                              userID16.toString() +
                              userID17.toString() +
                              userID18.toString();
                        });
                        Future.delayed(const Duration(seconds: 1), () async {
                          final response = await CreateUserApi.registerUserData(
                              context: context,
                              userName: cnUser.text,
                              phoneNumber: phoneNumber.toString(),
                              password: cnPassword.text,
                              userID: theUniqueID.toString());

                          // END CREATE USER API CALL

                          if (response.message ==
                              "Unable to reach the internet! Ple ase try again in  a minutes or two") {
                            Navigator.pushNamed(context, '/lossConnection');
                          } else if (response.data == null) {
                            showAlertInternetWarningMessage(
                                message: "Invalid Credentials",
                                context: context);
                          } else if (response.data!.message ==
                              "Phone Number Already Used") {
                            showAlertDialogThree(context: context);
                          } else {
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

                            setUserCredentials(
                              userName: response.data!.userData.userName,
                              userPhone: response.data!.userData.phoneNumber,
                              userId: response.data!.userData.userId,
                              registerStatus: true,
                            );
                            Navigator.pushNamed(context, '/homeNavigation');

                            showAlertDialogTwo(
                              alertMessage: "Successfully Register",
                              context: context,
                            );
                          }
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/loginUser');
                    },
                    child: appRichTextWidget(
                        textOne: "already registerd? ", textTwo: "Login Now"),
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
