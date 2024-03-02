import 'dart:convert';
import 'dart:io';

import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/addStockProductModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NetworkResponse<AddStockProductModal>> addToStocktData({
  required BuildContext context,
  required String cartNumber,
  required String userID,
  required String productName,
  required String productCategory,
  required String productImage,
  required String productID,
  required String productQuantity,
  required String cartID,
  required String quantityCategory,
  required String purchaseDate,
}) async {
  try {
    final data = http.MultipartRequest('POST',
        Uri.parse('http://18.183.210.225//cartlist_api/addtostock.php'));
    data.fields.addAll({
      'pass_userID': userID,
      'pass_product_name': productName,
      'pass_product_category': productCategory,
      'pass_product_image': productImage,
      'pass_product_id': productID,
      'pass_productquantity': productQuantity,
      'pass_cartid': cartID,
      'pass_quantitycategory': quantityCategory,
      'access_datepurchase': purchaseDate,
    });

    http.StreamedResponse response = await data.send();

    if (response.statusCode == 200) {
      final jsonString = jsonDecode(await response.stream.bytesToString());

      AddStockProductModal stockDatamodal =
          AddStockProductModal.fromJson(jsonString);

      return NetworkResponse(true, stockDatamodal,
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
