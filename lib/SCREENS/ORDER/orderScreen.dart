import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/MODAL/stockProductModal.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/PROVIDER/stockProductProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SERVICE/deleteCartProduct.dart';
import 'package:cartlist/SERVICE/getStockProduct.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  String? profileUserName;
  String? profileUserPhone;
  String? profileUserID;

  void getSharePrefData() {
    setState(() {
      profileUserName = preferences!.getString("UserName");
      profileUserPhone = preferences!.getString("UserPhone");
      profileUserID = preferences!.getString("userId");
    });
  }

  screenReloadFunction() {
    getStockProductResponse(
        context: context, profileUserID: profileUserID.toString());
    showAlertDialogRefresh(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final quantityProvider = Provider.of<QuantityProvider>(context);
    final stockProductProvider = Provider.of<StockProductProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: stockProductProvider.postList.length == 0
            ? Center(
                child: Image.asset(emptyBox),
              )
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stockProductProvider.postList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  mainAxisExtent: MediaQuery.of(context).size.height / 3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: ((context, index) {
                  StockProductModal modalResponse =
                      stockProductProvider.getPostByIndex(index);
                  return StockGridCard(
                    productImage: modalResponse.productImage,
                    productName: modalResponse.productName,
                    productCountCategory: modalResponse.quantityCategory,
                    submitAction: () {
                      String? finalQuantity;
                      if (modalResponse.quantityCategory == 'KG') {
                        setState(() {
                          finalQuantity = quantityProvider.productCountKG;
                        });
                      } else if (modalResponse.quantityCategory == 'LITER') {
                        setState(() {
                          finalQuantity = quantityProvider.productCountLITTER;
                        });
                      } else if (modalResponse.quantityCategory == 'PAK') {
                        setState(() {
                          finalQuantity = quantityProvider.productCountPAK;
                        });
                      } else {
                        print("No Category");
                      }

                      Navigator.of(context).pop(true);
                      addToCartData(
                        context: context,
                        cartNumber: modalResponse.number,
                        userID: profileUserID.toString(),
                        phoneNumber: profileUserPhone.toString(),
                        productName: modalResponse.productName,
                        productBrand: '',
                        productCategory: modalResponse.productCategory,
                        productImage: modalResponse.productImage,
                        productID: modalResponse.productId,
                        productQuantity: finalQuantity.toString(),
                        quantityCategory: modalResponse.quantityCategory,
                      );
                    },
                    favAction: () {
                      showAlertDialogWarning(
                        context: context,
                        confirmAction: () {
                          stockProductProvider.postList.clear();
                          Future.delayed(const Duration(seconds: 2), () {
                            screenReloadFunction();
                          });
                          deleteStockProduct(
                            userID: profileUserID.toString(),
                            context: context,
                            cartID: modalResponse.cartId,
                          );
                        },
                        messageText: "Delete This Product from favorite",
                        confirmButtonText: "Delete",
                      );
                    },
                    favButtonIcon: Icons.delete,
                    purchaseDate: modalResponse.stockId,
                    quantity: modalResponse.productQuantity,
                  );
                }),
              ),
      ),
    );
  }
}
