import 'package:cartlist/RESOURCE/colorFile.dart';
import 'package:flutter/cupertino.dart';

Widget appRichTextWidget({
  required String textOne,
  required String textTwo,
}) {
  return RichText(
    text: TextSpan(children: [
      TextSpan(
        text: textOne,
        style: const TextStyle(color: colorBlack),
      ),
      TextSpan(
        text: textTwo,
        style:
            const TextStyle(color: colorPrimary, fontWeight: FontWeight.bold),
      ),
    ]),
  );
}

Widget boldText({
  required String labelText,
}) {
  return Text(
    labelText,
    style: const TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget normalTextWithPadding({
  required String labelText,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5),
    child: Text(labelText),
  );
}
