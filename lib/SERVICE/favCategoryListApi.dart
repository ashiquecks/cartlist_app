import 'dart:convert';
import 'dart:io';
import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/SERVICE/getFavProductByCategoryApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

// MAJOR API CALLIG CLASS
class FavCategoryNameservice {
  static Future<NetworkResponse<List<FavCategoryNameModal>>>
      getFavCategoryResponse({
    required BuildContext context,
    required String UserID,
  }) async {
    var providerFavProductCt =
        Provider.of<FavoriteProductCategoryProvider>(context, listen: false);
    final providerFavName =
        Provider.of<FavCategoryNameProvider>(context, listen: false);
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getcategorynames.php?userID=$UserID'));

      if (response.statusCode == 200) {
        if (response.body.length == 12) {
          providerFavName.changeListStatus(true);

          List<FavCategoryNameModal> cartList = [];

          return NetworkResponse(true, cartList,
              responseCode: response.statusCode);
        } else {
          providerFavName.changeListStatus(false);
          var body = jsonDecode(response.body);

          providerFavName.changeSelectFavID(body[0]['category_id']);

          getFavCategoryProductResponse(
              context: context, favCategoryId: body[0]['category_id']);

          List<FavCategoryNameModal> cartList = [];
          body.forEach((e) {
            FavCategoryNameModal cartResponse =
                FavCategoryNameModal.fromJson(e);
            cartList.add(cartResponse);
          });

          return NetworkResponse(true, cartList,
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
