import 'dart:io';

import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/FUNCTIONS/cartAlertBox.dart';
import 'package:cartlist/FUNCTIONS/internetConnection.dart';
import 'package:cartlist/MODAL/getCartModal.dart';
import 'package:cartlist/PROVIDER/getCartProvider.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/PROVIDER/stockProductProvider.dart';
import 'package:cartlist/PROVIDER/whatsAppProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/CART/emptyCartScreen.dart';
import 'package:cartlist/SCREENS/CATEGORY/slectFavCategory.dart';
import 'package:cartlist/SCREENS/REFRESH/refreshScree.dart';
import 'package:cartlist/SERVICE/addToStockApi.dart';
import 'package:cartlist/SERVICE/deleteCartProduct.dart';
import 'package:cartlist/SERVICE/getCardListApi.dart';
import 'package:cartlist/SERVICE/getStockProduct.dart';
import 'package:cartlist/SERVICE/updateToCart.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  final String uniqUserID;
  const CartScreen({super.key, required this.uniqUserID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Cart Response Post To Cart Provider
  getCartResponse() async {
    var provider = Provider.of<GetCartProvider>(context, listen: false);
    var response = await GetCartservice.getCartResponse(
        context: context, cartUserID: profileUserID.toString());

    if (response.isSuccessful!) {
      provider.setPostList(response.data!);
    } else if (response.message ==
        "Unable to reach the internet! Ple ase try again in  a minutes or two") {
      Navigator.pushNamed(context, '/lossConnection');
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getSharePrefData();
    getCartResponse();
  }

  screenReloadFunction() {
    showAlertDialogRefresh(context: context);
    getSharePrefData();
    getCartResponse();
    setState(() {});
  }

  String? profileUserName;
  String? profileUserPhone;
  String? profileUserID;

  //ADDRESS SHARED PREFERENCE

  String? addressHouseName;
  String? addressLandMark;
  String? addressPlace;
  String? addressPostCode;
  String? addressCity;

  bool? addressShareConfirm;

  void getSharePrefData() {
    setState(() {
      profileUserName = preferences!.getString("UserName");
      profileUserPhone = preferences!.getString("UserPhone");
      profileUserID = preferences!.getString("userId");

      //ADDRESS SHARED PREFERENCE

      addressHouseName = addresspreference!.getString("UserHoseName");
      addressLandMark = addresspreference!.getString("UserLandMark");
      addressPlace = addresspreference!.getString("UserPlace");
      addressPostCode = addresspreference!.getString("UserPostcode");
      addressCity = addresspreference!.getString("UserCity");

      //ADDRESS SHARED CONFIRMATION

      addressShareConfirm = addresspreference!.getBool("AddressShare");
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerStockProduct = Provider.of<StockProductProvider>(context);
    final cartProvider = Provider.of<GetCartProvider>(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);
    final widgetSize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (() async {
        cartProvider.postList.clear();
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: Stack(
          children: [
            Visibility(
              visible: cartProvider.listIsEmpty,
              child: Center(child: Image.asset(emptyCart)),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.postList.length,
              itemBuilder: ((context, index) {
                GetCartModal modalResponse = cartProvider.getPostByIndex(index);
                return CartCard(
                  cartProductName: modalResponse.productName,
                  cartProductQuantity: modalResponse.productQuantity,
                  deleteAction: () {
                    // cartProvider.postList.clear();
                    showAlertDialogWarning(
                      context: context,
                      confirmAction: () {
                        cartProvider.postList.clear();
                        Future.delayed(const Duration(seconds: 2), () {
                          screenReloadFunction();
                        });
                        deleteCartProduct(
                          userID: profileUserID.toString(),
                          context: context,
                          cartID: modalResponse.cartId,
                        );
                      },
                      messageText: "Delete This Product from cart",
                      confirmButtonText: "Delete",
                    );
                  },
                  cartProductImage: modalResponse.productImage,
                  editAction: () {
                    if (modalResponse.quantityCategory == "KG") {
                      quantityAlertDialogBoxKG(
                        context: context,
                        submitAction: () {
                          cartProvider.postList.clear();
                          Future.delayed(const Duration(seconds: 2), () {
                            screenReloadFunction();
                          });
                          updateToCartData(
                            context: context,
                            productQuantity: quantityProvider.productCountKG,
                            cartID: modalResponse.cartId,
                          );
                          Navigator.of(context).pop(true);
                        },
                      );
                    } else if (modalResponse.quantityCategory == "LITER") {
                      quantityAlertDialogBoxLiter(
                        context: context,
                        submitAction: () {
                          cartProvider.postList.clear();
                          Future.delayed(const Duration(seconds: 2), () {
                            screenReloadFunction();
                          });
                          updateToCartData(
                            context: context,
                            productQuantity:
                                quantityProvider.productCountLITTER,
                            cartID: modalResponse.cartId,
                          );
                          Navigator.of(context).pop(true);
                        },
                      );
                    } else if (modalResponse.quantityCategory == "PAK") {
                      quantityAlertDialogBoxPak(
                        context: context,
                        submitAction: () {
                          cartProvider.postList.clear();
                          Future.delayed(const Duration(seconds: 2), () {
                            screenReloadFunction();
                          });
                          updateToCartData(
                            context: context,
                            productQuantity: quantityProvider.productCountPAK,
                            cartID: modalResponse.cartId,
                          );
                          Navigator.of(context).pop(true);
                        },
                      );
                    } else {
                      print("No category");
                    }
                  },
                  favAction: () {
                    showModalBottomSheet(
                      context: context,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      builder: (BuildContext context) {
                        return SelectFavCategory(
                          profileID: profileUserID.toString(),
                          productCountCategory: modalResponse.quantityCategory,
                          productID: modalResponse.productId,
                          productImage: modalResponse.productImage,
                          productName: modalResponse.productName,
                          cartNumber: modalResponse.number,
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 100,
          width: widgetSize,
          decoration: const BoxDecoration(
            color: colorWhite,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: shadowGrey,
              )
            ],
          ),
          child: Column(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return loginButton(
                    context: context,
                    buttonText: "Share Your List",
                    buttonAction: () async {
                      if (addressShareConfirm == true) {
                        print("((((((((((((((((((()))))))))))))))))))");
                        print("SHARE ADDRESS ENABLE");
                      } else {
                        print("((((((((((((((((((()))))))))))))))))))");
                        print("SHARE ADDRESS NOT ENABLE");
                      }
                      // CLEAR STOCK PROVIDER LIST
                      providerStockProduct.postList.clear();
                      _onShare(
                        cartID: '',
                        cartNumber: '',
                        context: context,
                        productCategory: '',
                        productID: '',
                        productImage: '',
                        productName: '',
                        productQuantity: '',
                        quantityCategory: '',
                        userID: '',
                      );
                      var urls =
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png';
                      final url = Uri.parse(urls);
                      final res = await http.get(url);
                      final bytes = res.bodyBytes;
                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/imageToShare.jpg';
                      File(path).writeAsBytesSync(bytes);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onShare({
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
  }) async {
    final cartProvider = Provider.of<GetCartProvider>(context, listen: false);
    final whatssprovider =
        Provider.of<WhatsAppProvider>(context, listen: false);
    final box = context.findRenderObject() as RenderBox?;

    var urls =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png';
    final url = Uri.parse(urls);
    final res = await http.get(url);
    final bytes = res.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/imageToShare.jpg';
    File(path).writeAsBytesSync(bytes);

    if (addressShareConfirm == true) {
      await Share.shareFiles([path],
          text: profileUserName.toString().toUpperCase() +
              '\n' +
              addressHouseName.toString().toUpperCase() +
              '\n' +
              addressLandMark.toString().toUpperCase() +
              '\n' +
              addressPlace.toString().toUpperCase() +
              '\n' +
              addressPostCode.toString().toUpperCase() +
              ',  ' +
              addressCity.toString().toUpperCase() +
              '\n' +
              profileUserPhone.toString().toUpperCase() +
              '\n' +
              '' +
              '${whatssprovider.shareWhatsAppText}');
    } else {
      await Share.shareFiles([path],
          text: '${whatssprovider.shareWhatsAppText}');
    }

    DateTime dateToday = new DateTime.now();
    String dateNext = dateToday.toString().substring(0, 10);
    String filterYear = dateNext.replaceAll('2023-', '');
    print(dateNext);

    for (int i = 0; i < cartProvider.postList.length; i++) {
      addToStocktData(
        context: context,
        cartNumber: cartProvider.postList[i].number,
        userID: cartProvider.postList[i].userId,
        productName: cartProvider.postList[i].productName,
        productCategory: cartProvider.postList[i].productCategory,
        productImage: cartProvider.postList[i].productImage,
        productID: cartProvider.postList[i].productId,
        productQuantity: cartProvider.postList[i].productQuantity,
        cartID: cartProvider.postList[i].cartId,
        quantityCategory: cartProvider.postList[i].quantityCategory,
        purchaseDate: filterYear.toString(),
      );

      Future.delayed(const Duration(seconds: 2), () {
        for (int i = 0; i < cartProvider.postList.length; i++) {
          deleteAllCartProduct(
            userID: cartProvider.postList[i].userId,
            context: context,
            cartID: cartProvider.postList[i].cartId,
          );
        }
      });

      Future.delayed(Duration(seconds: 3), () {
        cartProvider.postList.clear();

        //GET STOCK PRODUCT
        getStockProductResponse(
          context: context,
          profileUserID: profileUserID.toString(),
        );
      });
    }
  }
}
