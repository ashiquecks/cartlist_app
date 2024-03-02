// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/FUNCTIONS/cartAlertBox.dart';
import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:cartlist/MODAL/productModal.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/productProvider.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';

import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/CATEGORY/slectFavCategory.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SERVICE/favCategoryListApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListByCategories extends StatefulWidget {
  const ProductListByCategories({super.key});

  @override
  State<ProductListByCategories> createState() =>
      _ProductListByCategoriesState();
}

class _ProductListByCategoriesState extends State<ProductListByCategories> {
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

  @override
  void initState() {
    super.initState();
    getSharePrefData();
    getFavCategoryResponse(
      context: context,
      profileUserID: profileUserID.toString(),
    );
  }

  String? selectedIndex = "vegitable";

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        productProvider.postList.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "ProductList",
            style: TextStyle(color: colorWhite),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: productProvider.postList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.4),
              mainAxisExtent: MediaQuery.of(context).size.height / 2.8,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: ((context, index) {
              ProductModal modalResponse =
                  productProvider.getPostByIndex(index);
              return ProductGridCard(
                productImage: "http://18.183.210.225/cartlist_api/" +
                    modalResponse.productImg,
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
                    productBrand: modalResponse.productBrand,
                    productCategory: modalResponse.productCategory,
                    productImage: "http://18.183.210.225/cartlist_api/" +
                        modalResponse.productImg,
                    productID: modalResponse.productId,
                    productQuantity: finalQuantity.toString(),
                    quantityCategory: modalResponse.countCategory,
                  );
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
                        productCountCategory: modalResponse.countCategory,
                        productID: modalResponse.productId,
                        productImage: "http://18.183.210.225/cartlist_api/" +
                            modalResponse.productImg,
                        productName: modalResponse.productName,
                        cartNumber: modalResponse.number,
                      );
                    },
                  );
                },
                favButtonIcon: Icons.favorite_outline,
              );
            }),
          ),
        ),
      ),
    );
  }
}
