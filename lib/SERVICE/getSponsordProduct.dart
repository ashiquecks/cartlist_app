import 'dart:convert';
import 'dart:io';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/sponserdProductModal.dart';
import 'package:http/http.dart';

class SponsordProductservice {
  static Future<NetworkResponse<List<SponsordProductModal>>>
      getSponsordProductResponse({int limit = 20, int page = 1}) async {
    try {
      final response = await get(Uri.parse(
          'http://18.183.210.225//cartlist_api/getsponserdproduct.php'));

      print(response.body);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<SponsordProductModal> sponsorList = [];
        body.forEach((e) {
          SponsordProductModal categoryResponse =
              SponsordProductModal.fromJson(e);
          sponsorList.add(categoryResponse);
        });
        return NetworkResponse(true, sponsorList,
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
