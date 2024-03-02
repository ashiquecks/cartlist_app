import 'package:cartlist/PROVIDER/categoryProvider.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/PROVIDER/favoriteProductProvider.dart';
import 'package:cartlist/PROVIDER/mainBannerProvider.dart';
import 'package:cartlist/PROVIDER/secondBannerProvider.dart';
import 'package:cartlist/PROVIDER/sponsorProductProvider.dart';
import 'package:cartlist/PROVIDER/stockProductProvider.dart';
import 'package:cartlist/SERVICE/favCategoryListApi.dart';
import 'package:cartlist/SERVICE/getCategoryApi.dart';
import 'package:cartlist/SERVICE/getFavProductByCategoryApi.dart';
import 'package:cartlist/SERVICE/getFavoriteProduct.dart';
import 'package:cartlist/SERVICE/getMainBannerApi.dart';
import 'package:cartlist/SERVICE/getSecondBannerApi.dart';
import 'package:cartlist/SERVICE/getSponsordProduct.dart';
import 'package:cartlist/SERVICE/getStockProduct.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

getSponsorProductResponse({required BuildContext context}) async {
  var provider = Provider.of<SponsorProductProvider>(context, listen: false);
  var response = await SponsordProductservice.getSponsordProductResponse();

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getMainBannerResponse({required BuildContext context}) async {
  var provider = Provider.of<MainBannerProvider>(context, listen: false);
  var response = await MainBannerService.getMainBanerResponse();

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

getSecondBannerResponse({required BuildContext context}) async {
  var provider = Provider.of<SecondBannerProvider>(context, listen: false);
  var response = await SecondBannerService.getSecondBanerResponse();

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

// FavProduct Response Post To FavProduct Provider
// getFavProductResponse(
//     {required BuildContext context, required String profileUserID}) async {
//   var provider = Provider.of<FavoriteProductProvider>(context, listen: false);
//   var response = await GetFavoriteservice.getFavoriteResponse(
//     context: context,
//     profileUserID: profileUserID,
//   );

//   if (response.isSuccessful!) {
//     provider.setPostList(response.data!);
//   } else if (response.message ==
//       "Unable to reach the internet! Ple ase try again in  a minutes or two") {
//     Navigator.pushNamed(context, '/lossConnection');
//   } else {}
// }

//Get Ctegory Favorite Product

getFavCategoryProductResponse(
    {required BuildContext context, required String favCategoryId}) async {
  var providerFavProductCt =
      Provider.of<FavoriteProductCategoryProvider>(context, listen: false);

  var response = await GetFavoritCTProducteservice.getFavoriteCtProductResponse(
    context: context,
    favCategoryID: favCategoryId,
  );

  if (response.isSuccessful!) {
    providerFavProductCt.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

// FavoriteCategory Response Post To FavoriteCategory Provider
getFavCategoryResponse(
    {required BuildContext context, required String profileUserID}) async {
  var provider = Provider.of<FavCategoryNameProvider>(context, listen: false);
  var response = await FavCategoryNameservice.getFavCategoryResponse(
      UserID: profileUserID, context: context);

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

// Category Response Post To Category Provider
getCategoryResponse({required BuildContext context}) async {
  var provider = Provider.of<CategoryProvider>(context, listen: false);
  var response = await Categoryservice.getCategoryResponse();

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}

// FavoriteCategory Response Post To FavoriteCategory Provider
getStockProductResponse(
    {required BuildContext context, required String profileUserID}) async {
  var provider = Provider.of<StockProductProvider>(context, listen: false);
  var response = await GetStockservice.getStockResponse(
      UserID: profileUserID.toString(), context: context);

  if (response.isSuccessful!) {
    provider.setPostList(response.data!);
  } else if (response.message ==
      "Unable to reach the internet! Ple ase try again in  a minutes or two") {
    Navigator.pushNamed(context, '/lossConnection');
  } else {}
}
