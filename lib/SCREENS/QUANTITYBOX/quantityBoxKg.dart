import 'package:cartlist/LOCALDATA/quantityList.dart';
import 'package:cartlist/PROVIDER/quantityProvider.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/WIDGETS/buttonWidgets.dart';
import 'package:cartlist/WIDGETS/cardWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityBoxKG extends StatelessWidget {
  final void Function() submitAction;
  const QuantityBoxKG({super.key, required this.submitAction});

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
              itemCount: KG.length,
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
                          color: quantityProvider.productCountKG ==
                                  KG[index]['label']
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 12,
                        child: Text(
                          KG[index]['label']!,
                          style: TextStyle(
                            color: KG[index]['label'] ==
                                    quantityProvider.productCountKG
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
                          value: KG[index]['label'],
                          groupValue: quantityProvider.productCountKG,
                          onChanged: (value) {
                            quantityProvider.setQuantityKG(value!);
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
              quantity: quantityProvider.productCountKG,
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
