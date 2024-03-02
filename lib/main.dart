import 'package:cartlist/PROVIDER/categoryProvider.dart';
import 'package:cartlist/PROVIDER/favCategoryNameProvider.dart';
import 'package:cartlist/PROVIDER/favProductCategoryProvider.dart';
import 'package:cartlist/PROVIDER/favoriteProductProvider.dart';

import 'package:cartlist/PROVIDER/getCartProvider.dart';
import 'package:cartlist/PROVIDER/mainBannerProvider.dart';

import 'package:cartlist/PROVIDER/productProvider.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/PROVIDER/secondBannerProvider.dart';
import 'package:cartlist/PROVIDER/sponsorProductProvider.dart';
import 'package:cartlist/PROVIDER/stockProductProvider.dart';
import 'package:cartlist/PROVIDER/userLoginProvider.dart';
import 'package:cartlist/PROVIDER/whatsAppProvider.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/loginUser.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/otpVerification.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/phoneVerification.dart';
import 'package:cartlist/SCREENS/AUTHENTICATION/registerUser.dart';
import 'package:cartlist/SCREENS/CART/cartScreen.dart';
import 'package:cartlist/SCREENS/CART/emptyCartScreen.dart';
import 'package:cartlist/SCREENS/CATEGORY/category.dart';
import 'package:cartlist/SCREENS/CATEGORY/productList.dart';
import 'package:cartlist/SCREENS/CATEGORY/slectFavCategory.dart';
import 'package:cartlist/SCREENS/CATEGORY/subCategory.dart';
import 'package:cartlist/SCREENS/DEMO/demoScreen.dart';
import 'package:cartlist/SCREENS/FAVORITE/createFavoriteBox.dart';
import 'package:cartlist/SCREENS/FAVORITE/favoriteScreen.dart';
import 'package:cartlist/SCREENS/HOME/homeNavigation.dart';
import 'package:cartlist/SCREENS/HOME/homeScreen.dart';
import 'package:cartlist/SCREENS/INTERNET/lossConnection.dart';
import 'package:cartlist/SCREENS/PROFILE/profileScreen.dart';
import 'package:cartlist/SCREENS/PROFILE/registerAddress.dart';
import 'package:cartlist/SCREENS/SEARCHPRODUCT/searchProduct.dart';
import 'package:cartlist/SCREENS/SPLASH/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => QuantityProvider()),
        ChangeNotifierProvider(create: (context) => GetCartProvider()),
        ChangeNotifierProvider(create: (context) => WhatsAppProvider()),
        ChangeNotifierProvider(create: (context) => FavCategoryNameProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProductProvider()),
        ChangeNotifierProvider(
            create: (context) => FavoriteProductCategoryProvider()),
        ChangeNotifierProvider(create: (context) => StockProductProvider()),
        ChangeNotifierProvider(create: (context) => SponsorProductProvider()),
        ChangeNotifierProvider(create: (context) => MainBannerProvider()),
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
        ChangeNotifierProvider(create: (context) => SecondBannerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) => const SplashScreen(),
          '/loginUser': (context) => const LoginUser(),
          '/registerUser': (context) => const RegisterUser(),
          '/phoneVerification': (context) => const PhoneVerification(),
          '/otpVerification': (context) => const OTPVerification(
                phoneNumber: '',
              ),
          '/lossConnection': (context) => const LossConnection(),
          '/homeNavigation': (context) => const HomeNavigation(),
          '/homeScreen': (context) => const HomeScreen(),
          '/categoryScreen': (context) => const CategoryScreen(),
          '/cartScreen': (context) => const CartScreen(
                uniqUserID: '',
              ),
          '/favoriteScreen': (context) => const FavoriteScreen(),
          '/profileScreen': (context) => const ProfileScreen(),
          '/demoScreen': (context) => const DemoScreen(),
          '/subCategoryScreen': (context) => const SubCategoryScreen(),
          '/productListScreen': (context) => const ProductListByCategories(),
          '/searchProduct': (context) => const SearchProduct(),
          '/addAddress': (context) => const AddAddress(),
          '/emptyCart': (context) => const EmptyCart(),
          '/createFaVCollection': (context) => const CreateFavoriteBox(),
        },
      ),
    );
  }
}


                // child: FadeInImage.assetNetwork(
                //   placeholder: imagePlaceholder,
                //   image: categoryImage,

                // ),
