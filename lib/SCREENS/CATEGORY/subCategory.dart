import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subcategory",
          style: TextStyle(color: colorWhite),
        ),
      ),
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/productListScreen");
                },
                title: Text("Kitchen House Hold items"),
              ),
              Divider()
            ],
          );
        }),
      ),
    );
  }
}
