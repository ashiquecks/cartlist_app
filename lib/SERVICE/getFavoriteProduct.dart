import 'dart:convert';
import 'dart:io';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/favoriteProductModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GetFavoriteservice {
  static Future<NetworkResponse<List<FavProductModal>>> getFavoriteResponse({
    required BuildContext context,
    required String profileUserID,
  }) async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getfavoriteproduct.php?pass_userID=$profileUserID'));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        List<FavProductModal> favtList = [];
        body.forEach((e) {
          FavProductModal cartResponse = FavProductModal.fromJson(e);
          favtList.add(cartResponse);
        });

        return NetworkResponse(true, favtList,
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
