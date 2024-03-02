import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SERVICE/addFavProduct.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectFavCategory extends StatefulWidget {
  final String profileID;
  final String cartNumber;
  final String productName;
  final String productImage;
  final String productID;
  final String productCountCategory;
  const SelectFavCategory({
    super.key,
    required this.profileID,
    required this.productName,
    required this.productImage,
    required this.productID,
    required this.productCountCategory,
    required this.cartNumber,
  });

  @override
  State<SelectFavCategory> createState() => _SelectFavCategoryState();
}

class _SelectFavCategoryState extends State<SelectFavCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerFavProductCt =
        Provider.of<FavoriteProductCategoryProvider>(context, listen: false);

    final providerFavName = Provider.of<FavCategoryNameProvider>(context);
    return WillPopScope(
      onWillPop: (() async {
        // providerFavName.postList.clear();
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: const Text(
            "Select Favorite Category",
            style: TextStyle(fontSize: 15, color: colorBlack),
          ),
          actions: [],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              child: SizedBox(
                height: 60,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/createFaVCollection');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Create Collection"),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
              child: SizedBox(
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(),
                  onPressed: () {
                    if (providerFavName.selectedFavItem == null) {
                      showAlertDialogError(
                          alertMessage: "Select Category", context: context);
                    } else {
                      addFavProduct(
                        context: context,
                        productName: widget.productName,
                        productImage: widget.productImage,
                        productID: widget.productID,
                        productCountCategory: widget.productCountCategory,
                        userID: widget.profileID,
                        favCategoryID: providerFavName.selectedFavID.toString(),
                        favCategoryName:
                            providerFavName.selectedFavItem.toString(),
                        cartNumber: widget.cartNumber,
                      );
                      //clear favorite category list
                      providerFavProductCt.postList.clear();
                      providerFavName.postList.clear();
                      Future.delayed(const Duration(seconds: 2), () async {
                        // second response calling
                        getFavCategoryResponse(
                          context: context,
                          profileUserID: widget.profileID,
                        );
                        // second response end
                      });
                    }
                  },
                  child: const Text("ADD TO FAVORITE"),
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Visibility(
                  visible: providerFavName.listIsEmpty,
                  child: collectionEmptyCard(),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: providerFavName.postList.length,
                  itemBuilder: (context, index) {
                    FavCategoryNameModal modalResponse =
                        providerFavName.getPostByIndex(index);
                    return Card(
                      child: RadioListTile(
                        activeColor: colorPrimary,
                        title: Text(modalResponse.categoryName),
                        value: modalResponse.categoryName,
                        groupValue: providerFavName.selectedFavItem,
                        onChanged: ((value) {
                          providerFavName.changeSelectFavItem(value!);
                          providerFavName
                              .changeSelectFavID(modalResponse.categoryId);
                        }),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
