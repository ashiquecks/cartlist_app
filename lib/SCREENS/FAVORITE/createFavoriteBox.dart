import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/SERVICE/addFavCategoryApi.dart';
import 'package:cartlist/SERVICE/favCategoryListApi.dart';
import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateFavoriteBox extends StatefulWidget {
  const CreateFavoriteBox({super.key});

  @override
  State<CreateFavoriteBox> createState() => _CreateFavoriteBoxState();
}

class _CreateFavoriteBoxState extends State<CreateFavoriteBox> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController favoriteCategory = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  String? profileUserID;

  void getSharePrefData() {
    setState(() {
      profileUserID = preferences!.getString("userId");
    });
  }

  // FavoriteCategory Response Post To FavoriteCategory Provider
  getFavCategoryResponse() async {
    var provider = Provider.of<FavCategoryNameProvider>(context, listen: false);
    var response = await FavCategoryNameservice.getFavCategoryResponse(
        UserID: profileUserID.toString(), context: context);

    if (response.isSuccessful!) {
      provider.setPostList(response.data!);
    } else {}
  }

  bool backButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    final providerFavName = Provider.of<FavCategoryNameProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        providerFavName.postList.clear();
        getFavCategoryResponse();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Collection"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: 180,
                        child: Image.asset(fillCollection),
                      ),
                      const Text(
                        "Create Your Collection",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: TextFormField(
                    controller: favoriteCategory,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("[0-9a-zA-Z' ']")),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Favorite Category',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Create Favorite Category";
                      }
                    }),
                  ),
                ),
                loginButton(
                  context: context,
                  buttonText: "CONFIRM",
                  buttonAction: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    String datetime = DateTime.now().toString();
                    String filterDTM =
                        datetime.replaceAll(RegExp(r'[^\w\s]+'), '');
                    String secondfilterDTM = filterDTM.replaceAll(' ', '');

                    final filterUserID =
                        profileUserID!.replaceAll(RegExp(r'[^0-9]'), '');

                    // String filterUserID = profileUserID.replaceAll();

                    showAlertDialogOne(context: context);

                    providerFavName.postList.clear();

                    Future.delayed(Duration(seconds: 1), () {
                      addFavCategoryName(
                        context: context,
                        userID: profileUserID!,
                        favCategoryID: filterUserID +
                            secondfilterDTM +
                            favoriteCategory.text,
                        favCategoryName: favoriteCategory.text,
                      );
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
