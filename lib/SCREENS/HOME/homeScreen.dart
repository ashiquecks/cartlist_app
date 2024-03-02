import 'package:carousel_slider/carousel_slider.dart';
import 'package:cartlist/APICALLBACK/callBackFunction.dart';
import 'package:cartlist/MODAL/sponserdProductModal.dart';
import 'package:cartlist/MODAL/stockProductModal.dart';
import 'package:cartlist/PROVIDER/mainBannerProvider.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/PROVIDER/secondBannerProvider.dart';
import 'package:cartlist/PROVIDER/sponsorProductProvider.dart';
import 'package:cartlist/PROVIDER/stockProductProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/CATEGORY/slectFavCategory.dart';
import 'package:cartlist/SERVICE/addToCartApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    var providerSponsorProduct = Provider.of<SponsorProductProvider>(context);
    var mainBannerProvider = Provider.of<MainBannerProvider>(context);
    var secondBannerProvider = Provider.of<SecondBannerProvider>(context);
    final stockProductProvider = Provider.of<StockProductProvider>(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/searchProduct');
              showAlertDialogRefresh(context: context);
            },
            child: Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 15, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorWhite,
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: shadowGrey,
                  )
                ],
              ),
              child: ListTile(
                leading: const Text("Search Products"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CarouselSlider(
              items: <Widget>[
                for (var i = 0; i < mainBannerProvider.postList.length; i++)
                  bannerCard(
                    bannerImage:
                        "http://18.183.210.225/cartlist_api/${mainBannerProvider.postList[i].bannerImage}",
                    context: context,
                  ),
              ],
              options: CarouselOptions(
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(
                  microseconds: 800,
                ),
                viewportFraction: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
              ),
            ),
          ),
          labelCard(buttonText: '', labelAction: () {}, labelText: 'sponsored'),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: providerSponsorProduct.postList.length,
              itemBuilder: ((context, index) {
                SponsordProductModal modalResponse =
                    providerSponsorProduct.getPostByIndex(index);
                return sponsorProductCard(
                  context: context,
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
                  productCountCategory: modalResponse.countCategory,
                  productImage:
                      "http://18.183.210.225/cartlist_api/${modalResponse.productImg}",
                  productName: modalResponse.productName,
                  submitActon: () {
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
                      productImage:
                          "http://18.183.210.225/cartlist_api/${modalResponse.productImg}",
                      productID: modalResponse.productId,
                      productQuantity: finalQuantity.toString(),
                      quantityCategory: modalResponse.countCategory,
                    );
                  },
                );
              }),
            ),
          ),
          stockProductProvider.postList.length < 4
              ? const SizedBox()
              : labelCard(
                  buttonText: '',
                  labelAction: () {},
                  labelText: 'order products'),
          stockProductProvider.postList.length < 4
              ? const SizedBox()
              : SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stockProductProvider.postList.length,
                    itemBuilder: ((context, index) {
                      StockProductModal modalResponse =
                          stockProductProvider.getPostByIndex(index);
                      return homeStockDisplayCard(
                        context: context,
                        favAction: () {},
                        favButtonIcon: Icons.favorite_outline,
                        productCountCategory: modalResponse.quantityCategory,
                        productImage: modalResponse.productImage,
                        productName: modalResponse.productName,
                        purchaseDate: modalResponse.stockId,
                        purchaseQuantity: modalResponse.productQuantity,
                      );
                    }),
                  ),
                ),
          secondBannerProvider.postList.length == 0
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CarouselSlider(
                    items: <Widget>[
                      for (var i = 0;
                          i < secondBannerProvider.postList.length;
                          i++)
                        bannerCard(
                          bannerImage:
                              "http://18.183.210.225/cartlist_api/${secondBannerProvider.postList[i].bannerImage}",
                          context: context,
                        ),
                    ],
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlayCurve: Curves.easeIn,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(
                        microseconds: 800,
                      ),
                      viewportFraction: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
