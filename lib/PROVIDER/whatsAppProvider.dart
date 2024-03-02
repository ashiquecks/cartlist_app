import 'package:flutter/cupertino.dart';

class WhatsAppProvider with ChangeNotifier {
  var shareWhatsAppText;

  setshareWhatsAppData(var whatsAppData) {
    shareWhatsAppText = whatsAppData;
    notifyListeners();
  }
}
