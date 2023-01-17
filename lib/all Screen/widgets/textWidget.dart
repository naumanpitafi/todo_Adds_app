import 'package:flutter/material.dart';

Widget text(context, text, size,
    {color = "", boldText = "", fontFamily = "", maxLines = 9}) {
  return Text(
    text,
    style: TextStyle(
      color: color == "" ? Colors.black : color,
      fontSize: size,
      fontWeight: boldText == "" ? FontWeight.normal : boldText,
      fontFamily: fontFamily == "" ? 'DM Sans' : fontFamily,
    ),
    maxLines: maxLines,
  );
}