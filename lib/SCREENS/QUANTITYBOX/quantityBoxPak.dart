import 'package:cartlist/LOCALDATA/quantityList.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityBoxPak extends StatelessWidget {
  final void Function() submitAction;
  const QuantityBoxPak({super.key, required this.submitAction});

  @override
  Widget build(BuildContext context) {
    final quantityProvider = Provider.of<QuantityProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          labelCardIcon(labelText: 'Select Quantity'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: GridView.builder(
              itemCount: PAK.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                mainAxisExtent: 40,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: ((context, index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                          color: quantityProvider.productCountPAK ==
                                  PAK[index]['label']
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 12,
                        child: Text(
                          PAK[index]['label']!,
                          style: TextStyle(
                            color: PAK[index]['label'] ==
                                    quantityProvider.productCountPAK
                                ? colorWhite
                                : colorPrimary,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 2,
                        child: Radio(
                          activeColor: Colors.transparent,
                          value: PAK[index]['label'],
                          groupValue: quantityProvider.productCountPAK,
                          onChanged: (value) {
                            quantityProvider.setQuantityPAK(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          quantityLabel(
              labelText: "Item Quantity",
              quantity: quantityProvider.productCountPAK,
              params: ""),
          squreBoxButton(
            context: context,
            buttonAction: submitAction,
          ),
        ],
      ),
    );
  }
}
