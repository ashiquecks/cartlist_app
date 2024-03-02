import 'package:cartlist/PROVIDER/whatsAppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void filterListString({
  required String filterText,
  required BuildContext context,
}) {
  final cartProvider = Provider.of<WhatsAppProvider>(context, listen: false);
  String filterONE = filterText.replaceAll("{", "\n");
  String filterTWO = filterONE.replaceAll("}", "\n");
  String filterTHREE = filterTWO.replaceAll("}", "\n");
  String filterFOUR = filterTHREE.replaceAll(",", "\n");
  String filterFIVE = filterFOUR.replaceAll("_", "  ");
  String filterSIX = filterFIVE.replaceAll("product", "");

  cartProvider.setshareWhatsAppData(filterSIX.toUpperCase());
}
