import 'dart:convert';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/favProductCategoryModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GetFavoritCTProducteservice {
  static Future<NetworkResponse<List<FavProductCategoryModal>>>
      getFavoriteCtProductResponse({
    required BuildContext context,
    required String favCategoryID,
  }) async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getfavproductbycategory.php?pass_favcategoryID=$favCategoryID'));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        List<FavProductCategoryModal> favCtProducttList = [];
        body.forEach((e) {
          FavProductCategoryModal favCtResponse =
              FavProductCategoryModal.fromJson(e);
          favCtProducttList.add(favCtResponse);
        });

        return NetworkResponse(true, favCtProducttList,
            responseCode: response.statusCode);
      } else {
        print("somthing else");
      }
    } catch (e) {
      print(e.toString());
    }
    throw Exception('Unexpected error occured!');
  }
}
