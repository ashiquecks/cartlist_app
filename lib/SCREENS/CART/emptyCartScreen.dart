import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (() async {
        Navigator.pushNamed(context, '/homeNavigation');
        return true;
      }),
      child: Scaffold(
        body: Center(
          child: Image.asset(emptyCart),
        ),
      ),
    );
  }
}
