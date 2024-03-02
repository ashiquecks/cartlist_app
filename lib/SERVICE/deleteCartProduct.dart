import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void deleteCartProduct({
  required String userID,
  required BuildContext context,
  required String cartID,
}) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('http://18.183.210.225//cartlist_api/deleteCartProduct.php'));
  request.fields.addAll({'pass_cartID': '$cartID'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Navigator.of(context).pop(true);

    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void deleteAllCartProduct({
  required String userID,
  required BuildContext context,
  required String cartID,
}) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('http://18.183.210.225//cartlist_api/deleteCartProduct.php'));
  request.fields.addAll({'pass_cartID': '$cartID'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void deleteFavoriteProduct({
  required String userID,
  required BuildContext context,
  required String favtID,
}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://18.183.210.225//cartlist_api/deletefavoriteproduct.php'));
  request.fields.addAll({'pass_favID': '$favtID'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Navigator.of(context).pop(true);

    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void deleteStockProduct({
  required String userID,
  required BuildContext context,
  required String cartID,
}) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('http://18.183.210.225//cartlist_api/deletestockproduct.php'));
  request.fields.addAll({'pass_cartID': '$cartID'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Navigator.of(context).pop(true);

    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
