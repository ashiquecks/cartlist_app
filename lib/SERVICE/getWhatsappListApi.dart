import 'dart:convert';
import 'dart:io';
import 'package:cartlist/FUNCTIONS/filterString.dart';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/whatsappModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class GetWhatsappListservice {
  static Future<NetworkResponse<List<WhatsappListModal>>> getWhatsappResponse({
    required BuildContext context,
    required String cartUserID,
  }) async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getwhatsapplist.php?userID=$cartUserID'));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        var stringList = body.join("");
        print(stringList);

        filterListString(filterText: stringList, context: context);

        List<WhatsappListModal> cartList = [];
        body.forEach((e) {
          WhatsappListModal cartResponse = WhatsappListModal.fromJson(e);
          cartList.add(cartResponse);
        });

        return NetworkResponse(true, cartList,
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
