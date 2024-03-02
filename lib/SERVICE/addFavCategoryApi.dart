import 'dart:convert';
import 'dart:io';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<FavCategoryNameModal>> addFavCategoryName({
  required BuildContext context,
  required String userID,
  required String favCategoryID,
  required String favCategoryName,
}) async {
  try {
    final data = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://18.183.210.225//cartlist_api/createcategoryfavorite.php'));
    data.fields.addAll({
      'pass_userid': userID,
      'pass_categoryname': favCategoryName,
      'pass_categoryid': favCategoryID,
    });

    http.StreamedResponse response = await data.send();

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(await response.stream.bytesToString());
      showAlertDialogTwo(alertMessage: "created collection", context: context);

      FavCategoryNameModal addFavDatamodal =
          FavCategoryNameModal.fromJson(jsonString);

      return NetworkResponse(true, addFavDatamodal,
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
