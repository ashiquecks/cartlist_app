import 'package:cartlist/FUNCTIONS/cartAlertBox.dart';
import 'package:cartlist/PROVIDER/categoryProvider.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/PROVIDER/favoriteProductProvider.dart';
import 'package:cartlist/PROVIDER/getCartProvider.dart';
import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/CATEGORY/category.dart';
import 'package:cartlist/SCREENS/FAVORITE/favoriteScreen.dart';
import 'package:cartlist/SCREENS/HOME/homeScreen.dart';
import 'package:cartlist/SCREENS/ORDER/orderScreen.dart';

import 'package:cartlist/SHAREDDPREFERENCE/cartListsSharedPref.dart';
import 'package:cartlist/WIDGETS/alertDialogBox.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

// http://18.183.210.225//cartlist_api/getsponserdproduct.php get all sponsor product

// http://18.183.210.225//cartlist_api/getmainbanner.php  get main banner data

// http://18.183.210.225//cartlist_api/getsecondbanner.php get second banner data

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    OrderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? profileUserID;

  void getSharePrefData() {
    setState(() {
      profileUserID = preferences!.getString("userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          leading: const SizedBox(),
          elevation: 0,
          title: SizedBox(
            width: widgetSize.width / 4,
            child: Image.asset(
              appLogo,
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            appBarButton(
              buttonIcon: Icons.shopping_cart_outlined,
              buttonAction: () {
                Navigator.pushNamed(context, '/cartScreen');
                showAlertDialogRefresh(context: context);
              },
            ),
            appBarButton(
              buttonIcon: Icons.person,
              buttonAction: () {
                Navigator.pushNamed(context, '/profileScreen');
              },
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: GNav(
            haptic: true,
            tabBorderRadius: 15,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 900),
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            color: Colors.grey[800],
            activeColor: Colors.lightGreen,
            iconSize: 24,
            tabBackgroundColor: Colors.lightGreen.withOpacity(0.1),
            tabMargin:
                const EdgeInsets.all(10), // selected tab background color
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5), // navigation bar padding
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.shoppingBag,
                text: 'Category',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Favorite',
              ),
              GButton(
                icon: LineIcons.alternateList,
                text: 'Order',
              ),
            ]),
      ),
    );
  }
}
