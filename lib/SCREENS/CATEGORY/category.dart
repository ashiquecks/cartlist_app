// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cartlist/MODAL/categoryModal.dart';
import 'package:cartlist/PROVIDER/categoryProvider.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/productProvider.dart';
import 'package:cartlist/SERVICE/getProductApi.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  String productCategory = "babycare";

  // Product Response Post To Product Provider
  postProductResponse({required String productCategory}) async {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    var response = await Productservice.getProductResponse(productCategory);

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
  }

  @override
  Widget build(BuildContext context) {
    final providerFavName = Provider.of<FavCategoryNameProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryProvider.postList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // childAspectRatio: MediaQuery.of(context).size.width /
          //     (MediaQuery.of(context).size.height / 1.4),
          mainAxisExtent: MediaQuery.of(context).size.height / 5.8,
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          CategoryModal modalResponse = categoryProvider.getPostByIndex(index);
          return gridCard(
              buttonAction: () {
                providerFavName.postList.clear();
                postProductResponse(
                    productCategory: modalResponse.categoryName);
                Navigator.pushNamed(context, '/productListScreen');
              },
              categoryImage: "http://18.183.210.225//cartlist_api/" +
                  modalResponse.categoryImg,
              categoryName: modalResponse.categoryName,
              context: context);
        },
      ),
    );
  }
}
