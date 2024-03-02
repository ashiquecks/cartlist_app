import 'package:cartlist/FUNCTIONS/quantityListClass.dart';
import 'package:cartlist/SCREENS/QUANTITYBOX/quantityBoxKg.dart';
import 'package:cartlist/SCREENS/QUANTITYBOX/quantityBoxLiter.dart';
import 'package:cartlist/SCREENS/QUANTITYBOX/quantityBoxPak.dart';
import 'package:flutter/material.dart';

quantityAlertDialogBoxKG({
  required BuildContext context,
  required void Function() submitAction,
}) {
  AlertDialog alert = AlertDialog(
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [QuantityBoxKG(submitAction: submitAction)],
        ),
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

quantityAlertDialogBoxLiter({
  required BuildContext context,
  required void Function() submitAction,
}) {
  AlertDialog alert = AlertDialog(
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [QuantityBoxLitter(submitAction: submitAction)],
        ),
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

quantityAlertDialogBoxPak({
  required BuildContext context,
  required void Function() submitAction,
}) {
  AlertDialog alert = AlertDialog(
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [QuantityBoxPak(submitAction: submitAction)],
        ),
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
