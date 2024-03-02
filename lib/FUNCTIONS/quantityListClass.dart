import 'package:cartlist/LOCALDATA/quantityList.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SERVICE/updateToCart.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityListKG extends StatefulWidget {
  final String productNumber;
  final String productName;
  final String productBrand;
  final String productCategory;
  final String productImage;
  final String productId;
  final String quantityCategory;
  final String productCartID;
  const QuantityListKG(
      {super.key,
      required this.productName,
      required this.productBrand,
      required this.productCategory,
      required this.productImage,
      required this.productId,
      required this.productNumber,
      required this.quantityCategory,
      required this.productCartID});

  @override
  State<QuantityListKG> createState() => _QuantityListKGState();
}

class _QuantityListKGState extends State<QuantityListKG> {
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

      //ADDRESS SHARED PREFERENCE
    });
  }

  String selectedItemCount = "25Gram";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          labelCardIcon(labelText: 'Select Quantity'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: GridView.builder(
              itemCount: KG.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisExtent: 40,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: ((context, index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                          color: selectedItemCount == KG[index]['label']
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 12,
                        child: Text(
                          KG[index]['label']!,
                          style: TextStyle(
                            color: KG[index]['label'] == selectedItemCount
                                ? colorWhite
                                : colorPrimary,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 2,
                        child: Radio(
                          activeColor: Colors.transparent,
                          value: KG[index]['label'],
                          groupValue: selectedItemCount,
                          onChanged: (value) {
                            setState(() {
                              selectedItemCount = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          quantityLabel(
              labelText: "Item Quantity",
              quantity: selectedItemCount,
              params: ""),
          squreBoxButton(
            context: context,
            buttonAction: () {
              Navigator.of(context).pop(true);
              addToCartData(
                context: context,
                cartNumber: widget.productNumber,
                userID: profileUserID.toString(),
                phoneNumber: profileUserPhone.toString(),
                productName: widget.productName,
                productBrand: widget.productBrand,
                productCategory: widget.productCategory,
                productImage: widget.productImage,
                productID: widget.productId,
                productQuantity: selectedItemCount,
                quantityCategory: widget.quantityCategory,
              );
            },
          ),
        ],
      ),
    );
  }
}

////////////////////////////////// Quantity Liter \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

class QuantityListLiter extends StatefulWidget {
  final String productNumber;
  final String productName;
  final String productBrand;
  final String productCategory;
  final String productImage;
  final String productId;
  final String quantityCategory;
  final String productCartID;
  const QuantityListLiter(
      {super.key,
      required this.productName,
      required this.productBrand,
      required this.productCategory,
      required this.productImage,
      required this.productId,
      required this.productNumber,
      required this.quantityCategory,
      required this.productCartID});

  @override
  State<QuantityListLiter> createState() => _QuantityListLiterState();
}

class _QuantityListLiterState extends State<QuantityListLiter> {
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

      //ADDRESS SHARED PREFERENCE
    });
  }

  String selectedItemCount = "25ML";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          labelCardIcon(labelText: 'Select Quantity'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: GridView.builder(
              itemCount: LITER.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisExtent: 40,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: ((context, index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                          color: selectedItemCount == LITER[index]['label']
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 12,
                        child: Text(
                          LITER[index]['label']!,
                          style: TextStyle(
                            color: LITER[index]['label'] == selectedItemCount
                                ? colorWhite
                                : colorPrimary,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 2,
                        child: Radio(
                          activeColor: Colors.transparent,
                          value: LITER[index]['label'],
                          groupValue: selectedItemCount,
                          onChanged: (value) {
                            setState(() {
                              selectedItemCount = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          quantityLabel(
              labelText: "Item Quantity",
              quantity: selectedItemCount,
              params: ""),
          squreBoxButton(
            context: context,
            buttonAction: () {
              Navigator.of(context).pop(true);
              addToCartData(
                context: context,
                cartNumber: widget.productNumber,
                userID: profileUserID.toString(),
                phoneNumber: profileUserPhone.toString(),
                productName: widget.productName,
                productBrand: widget.productBrand,
                productCategory: widget.productCategory,
                productImage: widget.productImage,
                productID: widget.productId,
                productQuantity: selectedItemCount,
                quantityCategory: widget.quantityCategory,
              );
            },
          ),
        ],
      ),
    );
  }
}

////////////////////////////////// Quantity Pak \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class QuantityListPak extends StatefulWidget {
  final String productNumber;
  final String productName;
  final String productBrand;
  final String productCategory;
  final String productImage;
  final String productId;
  final String quantityCategory;
  final String productCartID;
  const QuantityListPak(
      {super.key,
      required this.productName,
      required this.productBrand,
      required this.productCategory,
      required this.productImage,
      required this.productId,
      required this.productNumber,
      required this.quantityCategory,
      required this.productCartID});

  @override
  State<QuantityListPak> createState() => _QuantityListPakState();
}

class _QuantityListPakState extends State<QuantityListPak> {
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

      //ADDRESS SHARED PREFERENCE
    });
  }

  String selectedItemCount = "1Pak";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          labelCardIcon(labelText: 'Select Quantity'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: GridView.builder(
              itemCount: PAK.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisExtent: 40,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: ((context, index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                          color: selectedItemCount == PAK[index]['label']
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 12,
                        child: Text(
                          PAK[index]['label']!,
                          style: TextStyle(
                            color: PAK[index]['label'] == selectedItemCount
                                ? colorWhite
                                : colorPrimary,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 2,
                        child: Radio(
                          activeColor: Colors.transparent,
                          value: PAK[index]['label'],
                          groupValue: selectedItemCount,
                          onChanged: (value) {
                            setState(() {
                              selectedItemCount = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          quantityLabel(
              labelText: "Item Quantity",
              quantity: selectedItemCount,
              params: ""),
          squreBoxButton(
            context: context,
            buttonAction: () {
              Navigator.of(context).pop(true);
              addToCartData(
                context: context,
                cartNumber: widget.productNumber,
                userID: profileUserID.toString(),
                phoneNumber: profileUserPhone.toString(),
                productName: widget.productName,
                productBrand: widget.productBrand,
                productCategory: widget.productCategory,
                productImage: widget.productImage,
                productID: widget.productId,
                productQuantity: selectedItemCount,
                quantityCategory: widget.quantityCategory,
              );
            },
          ),
        ],
      ),
    );
  }
}
