import 'dart:convert';
import 'dart:io';
import 'package:cartlist/HELPER/categoryNetworkResponse.dart';
import 'package:cartlist/MODAL/mainBannerModal.dart';
import 'package:http/http.dart';

class MainBannerService {
  static Future<NetworkResponse<List<MainBannerModal>>> getMainBanerResponse(
      {int limit = 20, int page = 1}) async {
    try {
      final response = await get(
          Uri.parse('http://18.183.210.225//cartlist_api/getmainbanner.php'));

      print(response.body);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        List<MainBannerModal> bannerList = [];
        body.forEach((e) {
          MainBannerModal bannerResponse = MainBannerModal.fromJson(e);
          bannerList.add(bannerResponse);
        });
        return NetworkResponse(true, bannerList,
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
