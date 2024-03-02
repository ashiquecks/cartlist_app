import 'dart:convert';
import 'dart:io';
import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/createUserModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUserApi {
  static Future<NetworkResponse<CreateUserModal>> registerUserData({
    required BuildContext context,
    required String userName,
    required String phoneNumber,
    required String password,
    required String userID,
  }) async {
    try {
      final data = http.MultipartRequest('POST',
          Uri.parse('http://18.183.210.225/cartlist_api/createuser.php'));
      data.fields.addAll({
        'userName': userName,
        'phoneNumber': phoneNumber,
        'password': password,
        'userID': userID,
      });

      http.StreamedResponse response = await data.send();

      if (response.statusCode == 200) {
        final responsString = jsonDecode(await response.stream.bytesToString());

        CreateUserModal userDatamodal = CreateUserModal.fromJson(responsString);

        return NetworkResponse(true, userDatamodal,
            responseCode: response.statusCode);
      } else {
        return NetworkResponse(false, null,
            message:
                'Invalid response recived from server! please try again in a minutes or two',
            responseCode: response.statusCode);
      }
    } on SocketException {
      return NetworkResponse(
        false,
        null,
        message:
            "Unable to reach the internet! Ple ase try again in  a minutes or two",
      );
    } on FormatException {
      return NetworkResponse(
        false,
        null,
        message:
            "Invalid response receved form the server! Please try again in a minutes or two",
      );
    } catch (e) {
      return NetworkResponse(false, null,
          message: 'somthing went wrong please try again in a minute or two');
    }
    throw Exception('Unexpected error occured!');
  }
}
