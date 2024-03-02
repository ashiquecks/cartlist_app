import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loginButton({
  required BuildContext context,
  required String buttonText,
  required void Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colorPrimary),
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: const TextStyle(color: colorWhite),
        ),
      ),
    ),
  );
}

Widget cartButton({
  required BuildContext context,
  required String buttonText,
  required void Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 5, left: 5),
    child: SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    ),
  );
}

Widget favoriteButton() {
  return IconButton(
    icon: const Icon(Icons.favorite_border),
    onPressed: () {},
  );
}

Widget textIconButton({
  required String buttonText,
  required IconData buttonIcon,
  required Color buttonIconColor,
  required void Function() buttonAction,
}) {
  return TextButton.icon(
    icon: Icon(
      buttonIcon,
      color: buttonIconColor,
    ),
    onPressed: buttonAction,
    label: Text(
      buttonText,
      style: const TextStyle(color: Colors.grey),
    ),
  );
}

Widget squreBoxButton({
  required void Function() buttonAction,
  required BuildContext context,
}) {
  return InkWell(
    onTap: buttonAction,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: colorPrimary,
        height: 40,
        width: MediaQuery.of(context).size.width / 2.7,
        child: const Center(
          child: Text(
            "CONFIRM",
            style: TextStyle(color: colorWhite),
          ),
        ),
      ),
    ),
  );
}

Widget appBarButton({
  required IconData buttonIcon,
  required void Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      width: 50,
      child: Center(
        child: Card(
          child: IconButton(
            onPressed: buttonAction,
            icon: Icon(
              buttonIcon,
              color: colorBlack,
            ),
          ),
        ),
      ),
    ),
  );
}
