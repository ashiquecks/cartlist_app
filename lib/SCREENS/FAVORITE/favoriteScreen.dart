import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:cartlist/MODAL/favProductCategoryModal.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/PROVIDER/favoriteProductProvider.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SERVICE/deleteCartProduct.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
    getFavCategoryResponse(
        context: context, profileUserID: profileUserID.toString());
    showAlertDialogRefresh(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final providerFavName = Provider.of<FavCategoryNameProvider>(context);
    final providerFavProductByCategory =
        Provider.of<FavoriteProductCategoryProvider>(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SizedBox(
          height: 45,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: providerFavName.postList.length,
                  itemBuilder: ((context, index) {
                    FavCategoryNameModal modalResponse =
                        providerFavName.getPostByIndex(index);
                    return favoriteTabCard(
                      context: context,
                      responseCategoryID: modalResponse.categoryId,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      body: providerFavProductByCategory.postList.length == 0
          ? Center(
              child: Image.asset(emptyBag),
            )
          : GridView.builder(
              shrinkWrap: true,
              itemCount: providerFavProductByCategory.postList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisExtent: 270,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: ((context, index) {
                FavProductCategoryModal modalResponse =
                    providerFavProductByCategory.getPostByIndex(index);
                return ProductGridCard(
                  productImage: modalResponse.productImage,
                  productName: modalResponse.productName,
                  productCountCategory: modalResponse.countCategory,
                  submitAction: () {
                    String? finalQuantity;
                    if (modalResponse.countCategory == 'KG') {
                      setState(() {
                        finalQuantity = quantityProvider.productCountKG;
                      });
                    } else if (modalResponse.countCategory == 'LITER') {
                      setState(() {
                        finalQuantity = quantityProvider.productCountLITTER;
                      });
                    } else if (modalResponse.countCategory == 'PAK') {
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
                      productCategory: '',
                      productImage: modalResponse.productImage,
                      productID: modalResponse.productId,
                      productQuantity: finalQuantity.toString(),
                      quantityCategory: modalResponse.countCategory,
                    );
                  },
                  favAction: () {
                    showAlertDialogWarning(
                      context: context,
                      confirmAction: () {
                        providerFavName.postList.clear();
                        providerFavProductByCategory.postList.clear();
                        Future.delayed(const Duration(seconds: 2), () {
                          screenReloadFunction();
                        });
                        deleteFavoriteProduct(
                          userID: profileUserID.toString(),
                          context: context,
                          favtID: modalResponse.favoriteId,
                        );
                      },
                      messageText: "Delete This Product from favorite",
                      confirmButtonText: "Delete",
                    );
                  },
                  favButtonIcon: Icons.delete,
                );
              }),
            ),
    );
  }
}
