import 'dart:convert';
import 'dart:io';

import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/addFavProductModal.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<AddFavoriteProductModal>> addFavProduct({
  required BuildContext context,
  required String cartNumber,
  required String productName,
  required String productImage,
  required String productID,
  required String productCountCategory,
  required String favCategoryID,
  required String userID,
  required String favCategoryName,
}) async {
  try {
    final data = http.MultipartRequest('POST',
        Uri.parse('http://18.183.210.225//cartlist_api/addtofavorite.php'));
    data.fields.addAll({
      'pass_productname': productName,
      'pass_productimage': productImage,
      'pass_productid': productID,
      'pass_productcountcategory': productCountCategory,
      'pass_favcategoryname': favCategoryName,
      'pass_favcategoryid': favCategoryID, //fvcategory name id
      'pass_userID': userID,
      'pass_favID': userID + cartNumber + favCategoryName,
    });

    http.StreamedResponse response = await data.send();

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(await response.stream.bytesToString());

      showAlertDialogTwo(alertMessage: "Added to Favorite", context: context);

      AddFavoriteProductModal addFavDatamodal =
          AddFavoriteProductModal.fromJson(jsonString);

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
