import 'dart:async';
import 'package:cartlist/FUNCTIONS/cartAlertBox.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:cartlist/MODAL/searchProductModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _debouncer = Debouncer();

  List<SearchAllProduct> allProduct = [];
  List<SearchAllProduct> searchProduct = [];

  String url = 'http://18.183.210.225//cartlist_api/viewallproduct.php';

  Future<List<SearchAllProduct>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<SearchAllProduct> list = searchAllProductFromJson(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSharePrefData();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        allProduct = subjectFromServer;
        searchProduct = allProduct;
      });
    });
  }

  String? profileUserName;
  String? profileUserPhone;
  String? profileUserID;

  void getSharePrefData() {
    setState(() {
      profileUserName = preferences!.getString("UserName");
      profileUserPhone = preferences!.getString("UserPhone");
      profileUserID = preferences!.getString("userId");

      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quantityProvider = Provider.of<QuantityProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    searchProduct = allProduct
                        .where(
                          (u) => (u.productName.toString().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: searchProduct.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 80,
                  child: Card(
                    elevation:
                        searchProduct[index].productName == "noname" ? 0 : 4,
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          width: 70,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: searchProduct[index].productName == "noname"
                              ? SizedBox()
                              : Image.network(
                                  "http://18.183.210.225//cartlist_api/${searchProduct[index].productImg}"),
                        ),
                        title: Text(searchProduct[index].productName == "noname"
                            ? ""
                            : searchProduct[index].productName),
                        trailing: searchProduct[index].productName == "noname"
                            ? SizedBox()
                            : cartButton(
                                context: context,
                                buttonText: 'Add',
                                buttonAction: () {
                                  if (searchProduct[index].countCategory ==
                                      "KG") {
                                    quantityAlertDialogBoxKG(
                                      context: context,
                                      submitAction: () {
                                        addToCartData(
                                          context: context,
                                          cartNumber:
                                              searchProduct[index].number,
                                          userID: profileUserID.toString(),
                                          phoneNumber:
                                              profileUserPhone.toString(),
                                          productName:
                                              searchProduct[index].productName,
                                          productBrand:
                                              searchProduct[index].productBrand,
                                          productCategory: searchProduct[index]
                                              .productCategory,
                                          productImage:
                                              "http://18.183.210.225/cartlist_api/${searchProduct[index].productImg}",
                                          productID:
                                              searchProduct[index].productId,
                                          productQuantity:
                                              quantityProvider.productCountKG,
                                          quantityCategory: searchProduct[index]
                                              .countCategory,
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                    );
                                  } else if (searchProduct[index]
                                          .countCategory ==
                                      "LITER") {
                                    quantityAlertDialogBoxLiter(
                                      context: context,
                                      submitAction: () {
                                        addToCartData(
                                          context: context,
                                          cartNumber:
                                              searchProduct[index].number,
                                          userID: profileUserID.toString(),
                                          phoneNumber:
                                              profileUserPhone.toString(),
                                          productName:
                                              searchProduct[index].productName,
                                          productBrand:
                                              searchProduct[index].productBrand,
                                          productCategory: searchProduct[index]
                                              .productCategory,
                                          productImage:
                                              "http://18.183.210.225/cartlist_api/${searchProduct[index].productImg}",
                                          productID:
                                              searchProduct[index].productId,
                                          productQuantity: quantityProvider
                                              .productCountLITTER,
                                          quantityCategory: searchProduct[index]
                                              .countCategory,
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                    );
                                  } else if (searchProduct[index]
                                          .countCategory ==
                                      "PAK") {
                                    quantityAlertDialogBoxPak(
                                      context: context,
                                      submitAction: () {
                                        addToCartData(
                                          context: context,
                                          cartNumber:
                                              searchProduct[index].number,
                                          userID: profileUserID.toString(),
                                          phoneNumber:
                                              profileUserPhone.toString(),
                                          productName:
                                              searchProduct[index].productName,
                                          productBrand:
                                              searchProduct[index].productBrand,
                                          productCategory: searchProduct[index]
                                              .productCategory,
                                          productImage:
                                              "http://18.183.210.225/cartlist_api/${searchProduct[index].productImg}",
                                          productID:
                                              searchProduct[index].productId,
                                          productQuantity:
                                              quantityProvider.productCountPAK,
                                          quantityCategory: searchProduct[index]
                                              .countCategory,
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                    );
                                  } else {
                                    debugPrint("no category");
                                  }
                                },
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
