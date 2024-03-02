import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/FUNCTIONS/cartAlertBox.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/PROVIDER/getCartProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bannerCard({
  required String bannerImage,
  required BuildContext context,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.all(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: bannerImage,
        placeholder: (context, url) => Image.asset(imagePlaceholder),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      // child: Image.network(
      //   bannerImage,
      //   fit: BoxFit.cover,
      //   errorBuilder: (context, error, stackTrace) {
      //     return Image.asset(imagePlaceholder);
      //   },
      // ),
    ),
  );
}

Widget sponsorProductCard({
  required String productName,
  required String productImage,
  required BuildContext context,
  required IconData favButtonIcon,
  required void Function() favAction,
  required void Function() submitActon,
  required String productCountCategory,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 90,
                child: CachedNetworkImage(
                  imageUrl: productImage,
                  placeholder: (context, url) => Image.asset(imagePlaceholder),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(productName),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        icon: Icon(
                          favButtonIcon,
                          color: shadowGrey,
                          size: 15,
                        ),
                        onPressed: favAction,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (productCountCategory == "KG") {
                        quantityAlertDialogBoxKG(
                          context: context,
                          submitAction: submitActon,
                        );
                      } else if (productCountCategory == "LITER") {
                        quantityAlertDialogBoxLiter(
                          context: context,
                          submitAction: submitActon,
                        );
                      } else if (productCountCategory == "PAK") {
                        quantityAlertDialogBoxPak(
                          context: context,
                          submitAction: submitActon,
                        );
                      } else {
                        debugPrint("no category");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 6,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: colorPrimary),
                      ),
                      child: const Text("ADD"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget homeStockDisplayCard({
  required String productName,
  required String productImage,
  required String purchaseDate,
  required String purchaseQuantity,
  required BuildContext context,
  required IconData favButtonIcon,
  required void Function() favAction,
  required String productCountCategory,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 90,
                child: CachedNetworkImage(
                  imageUrl: productImage,
                  placeholder: (context, url) => Image.asset(imagePlaceholder),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(productName),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      purchaseDate,
                      style: const TextStyle(color: colorWhite),
                    ),
                  ),
                  normalTextWithPadding(labelText: purchaseQuantity),
                  // normalTextWithPadding(labelText: widget.purchaseDate),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget labelCard({
  required String labelText,
  required void Function() labelAction,
  required String buttonText,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.lightGreen),
          ),
        ),
      ],
    ),
  );
}

Widget labelCardIcon({
  required String labelText,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: colorPrimary,
          size: 20,
        )
      ],
    ),
  );
}

Widget gridCard({
  required String categoryImage,
  required String categoryName,
  required void Function() buttonAction,
  required BuildContext context,
}) {
  return InkWell(
    onTap: buttonAction,
    child: SizedBox(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
                child: CachedNetworkImage(
                  imageUrl: categoryImage,
                  placeholder: (context, url) => Image.asset(imagePlaceholder),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                // child: Image.network(
                //   categoryImage,
                //   errorBuilder: (context, error, stackTrace) {
                //     return const Text("Image Loading..");
                //   },
                // ),
              ),
              Text(categoryName),
            ],
          ),
        ),
      ),
    ),
  );
}

class CartCard extends StatelessWidget {
  final String cartProductName;
  final String cartProductImage;
  final String cartProductQuantity;
  final void Function() deleteAction;
  final void Function() editAction;
  final void Function() favAction;

  const CartCard({
    super.key,
    required this.cartProductName,
    required this.cartProductImage,
    required this.cartProductQuantity,
    required this.deleteAction,
    required this.editAction,
    required this.favAction,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetCartProvider>(context);
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(
                imageUrl: cartProductImage,
                placeholder: (context, url) => Image.asset(imagePlaceholder),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(cartProductName),
              subtitle: Text(cartProductQuantity),
              trailing: cartButton(
                  context: context,
                  buttonText: 'Edit',
                  buttonAction: editAction),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textIconButton(
                    buttonText: "Remove",
                    buttonIcon: Icons.delete,
                    buttonIconColor: shadowGrey,
                    buttonAction: deleteAction,
                  ),
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.grey,
                  ),
                  textIconButton(
                    buttonText: "Add to Favorite",
                    buttonIcon: Icons.favorite_outline,
                    buttonIconColor: shadowGrey,
                    buttonAction: favAction,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget quantityLabel({
  required String labelText,
  required String quantity,
  required String params,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(labelText),
        appRichTextWidget(textOne: "$quantity ", textTwo: params),
      ],
    ),
  );
}

class ProductGridCard extends StatefulWidget {
  final void Function() submitAction;
  final void Function() favAction;
  final String productImage;
  final String productName;
  final String productCountCategory;
  final IconData favButtonIcon;
  const ProductGridCard({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productCountCategory,
    required this.submitAction,
    required this.favAction,
    required this.favButtonIcon,
  });

  @override
  State<ProductGridCard> createState() => _ProductGridCardState();
}

class _ProductGridCardState extends State<ProductGridCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: CachedNetworkImage(
                imageUrl: widget.productImage,
                placeholder: (context, url) => Image.asset(imagePlaceholder),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            normalTextWithPadding(labelText: widget.productName),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                      icon: Icon(
                        widget.favButtonIcon,
                        color: shadowGrey,
                        size: 20,
                      ),
                      onPressed: widget.favAction,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.productCountCategory == "KG") {
                      quantityAlertDialogBoxKG(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else if (widget.productCountCategory == "LITER") {
                      quantityAlertDialogBoxLiter(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else if (widget.productCountCategory == "PAK") {
                      quantityAlertDialogBoxPak(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else {
                      debugPrint("no category");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colorPrimary),
                    ),
                    child: const Text("ADD"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget collectionEmptyCard() {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Center(
      child: SizedBox(
        height: 140,
        width: 160,
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: 140,
              child: Image.asset(emptyCollection),
            ),
            const Text("Your Collection Is Empty")
          ],
        ),
      ),
    ),
  );
}

Widget favoriteTabCard({
  required BuildContext context,
  // required String responseCategoryName,
  required String responseCategoryID,
}) {
  final providerFavName = Provider.of<FavCategoryNameProvider>(context);
  var providerFavProductCt =
      Provider.of<FavoriteProductCategoryProvider>(context, listen: false);
  return Container(
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: responseCategoryID == providerFavName.selectedFavID
          ? colorPrimary
          : colorWhite,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: colorPrimary),
    ),
    child: Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                responseCategoryID.replaceAll(RegExp('[0-9]'), ''),
                style: TextStyle(
                  color: responseCategoryID == providerFavName.selectedFavID
                      ? colorWhite
                      : colorPrimary,
                ),
              ),
            ),
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Radio(
                  activeColor: Colors.transparent,
                  value: responseCategoryID,
                  groupValue: providerFavName.selectedFavID,
                  onChanged: (value) async {
                    providerFavName.changeSelectFavID(value!);
                    providerFavProductCt.postList.clear();
                    getFavCategoryProductResponse(
                      context: context,
                      favCategoryId: value,
                    );
                    // var response = await GetFavoritCTProducteservice
                    //     .getFavoriteCtProductResponse(
                    //   context: context,
                    //   favCategoryID: value,
                    // );

                    // if (response.isSuccessful!) {
                    //   providerFavProductCt.setPostList(response.data!);
                    // } else {}
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class StockGridCard extends StatefulWidget {
  final void Function() submitAction;
  final void Function() favAction;
  final String productImage;
  final String productName;
  final String quantity;
  final String purchaseDate;
  final String productCountCategory;
  final IconData favButtonIcon;
  const StockGridCard({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productCountCategory,
    required this.submitAction,
    required this.favAction,
    required this.favButtonIcon,
    required this.quantity,
    required this.purchaseDate,
  });

  @override
  State<StockGridCard> createState() => _StockGridCardState();
}

class _StockGridCardState extends State<StockGridCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: CachedNetworkImage(
                imageUrl: widget.productImage,
                placeholder: (context, url) => Image.asset(imagePlaceholder),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  normalTextWithPadding(labelText: widget.productName),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.purchaseDate,
                          style: const TextStyle(color: colorWhite),
                        ),
                      ),
                      normalTextWithPadding(labelText: widget.quantity),
                      // normalTextWithPadding(labelText: widget.purchaseDate),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                      icon: Icon(
                        widget.favButtonIcon,
                        color: shadowGrey,
                        size: 20,
                      ),
                      onPressed: widget.favAction,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.productCountCategory == "KG") {
                      quantityAlertDialogBoxKG(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else if (widget.productCountCategory == "LITER") {
                      quantityAlertDialogBoxLiter(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else if (widget.productCountCategory == "PAK") {
                      quantityAlertDialogBoxPak(
                        context: context,
                        submitAction: widget.submitAction,
                      );
                    } else {
                      debugPrint("no category");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colorPrimary),
                    ),
                    child: const Text("ADD"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
