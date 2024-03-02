import 'package:flutter/material.dart';

class QuantityProvider with ChangeNotifier {
  String productCountKG = "25Gram";

  String productCountLITTER = "25ML";

  String productCountPAK = "1Pak";

  setQuantityKG(String passQuantittyKG) {
    productCountKG = passQuantittyKG;
    notifyListeners();
  }

  setQuantityLITTER(String passQuantityLITTER) {
    productCountLITTER = passQuantityLITTER;
    notifyListeners();
  }

  setQuantityPAK(String passQuantityPAK) {
    productCountPAK = passQuantityPAK;
    notifyListeners();
  }
}
