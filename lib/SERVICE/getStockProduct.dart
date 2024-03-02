import 'dart:convert';
import 'dart:io';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/stockProductModal.dart';
import 'package:cartlist/PROVIDER/getCartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class GetStockservice {
  static Future<NetworkResponse<List<StockProductModal>>> getStockResponse({
    int limit = 20,
    int page = 1,
    required BuildContext context,
    required String UserID,
  }) async {
    final cartProvider = Provider.of<GetCartProvider>(context, listen: false);
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getStockData.php?userID=$UserID'));

      if (response.statusCode == 200) {
        if (response.body.length == 12) {
          List<StockProductModal> stockList = [];

          // cartProvider.changeListStatus(true);

          return NetworkResponse(true, stockList,
              responseCode: response.statusCode);
        } else {
          var body = jsonDecode(response.body);

          // cartProvider.changeListStatus(false);

          List<StockProductModal> stockList = [];
          body.forEach((e) {
            StockProductModal stockResponse = StockProductModal.fromJson(e);
            stockList.add(stockResponse);
          });

          return NetworkResponse(true, stockList,
              responseCode: response.statusCode);
        }
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
