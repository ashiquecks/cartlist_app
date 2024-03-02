import 'package:cartlist/RESOURCE/assetFile.dart';
import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:cartlist/SCREENS/CATEGORY/slectFavCategory.dart';
import 'package:cartlist/SCREENS/FAVORITE/createFavoriteBox.dart';
import 'package:flutter/material.dart';

showAlertDialogOne({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: const [
      CircularProgressIndicator(
        color: Colors.green,
      ),
      SizedBox(width: 10),
      Text("Loading...")
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogRefresh({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 5,
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogTwo({
  required String alertMessage,
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: [
      const Icon(
        Icons.check_circle,
        size: 25,
        color: Colors.green,
      ),
      Text(alertMessage)
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogError({
  required String alertMessage,
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: [
      const Icon(
        Icons.warning,
        size: 25,
        color: Colors.red,
      ),
      Text(alertMessage)
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogThree({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: const [
      Icon(
        Icons.warning,
        size: 25,
        color: Colors.red,
      ),
      Text("Number Already Registerd")
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogWarning({
  required BuildContext context,
  required void Function() confirmAction,
  required String messageText,
  required String confirmButtonText,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );
  Widget continueButton = TextButton(
    child: Text(confirmButtonText),
    onPressed: confirmAction,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: Text(messageText),
    actions: [
      cancelButton,
      continueButton,
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

showAlertDialogCreateFavorite({
  required BuildContext context,
}) {
  AlertDialog alert = const AlertDialog(
    content: SizedBox(
      height: 160,
      child: CreateFavoriteBox(),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogAddFavorite({
  required BuildContext context,
}) {
  AlertDialog alert = const AlertDialog(
    content: SizedBox(
      height: 160,
      child: SizedBox(),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertInternetWarningMessage({
  required String message,
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
    content: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: Image.asset(incorrectPassword),
            ),
            Text(message)
          ],
        )),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}
