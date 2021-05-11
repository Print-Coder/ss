import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

Widget textH6(String text,
    {TextStyle textstyle, FontWeight fontWeight, int maxLines}) {
  return AutoSizeText(
    text,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w400, fontSize: 16),
    maxLines: maxLines ?? 1,
    // minFontSize: 2,
  );
}

Widget textB2(String text, {TextStyle textstyle}) {
  return AutoSizeText(
    text,
    style: textstyle,
    maxLines: 1,
  );
}

Widget textB1(String text, {TextStyle textstyle}) {
  return AutoSizeText(
    text,
    style: textstyle,
    maxLines: 1,
  );
}

Widget textH5(String text,
    {TextStyle textstyle, FontWeight fontWeight, int maxLines}) {
  return AutoSizeText(
    text,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w400, fontSize: 16),
    maxLines: maxLines ?? 1,
  );
}

Widget textH4(String text, {TextStyle textstyle, FontWeight fontWeight}) {
  return AutoSizeText(
    text,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500, fontSize: 17),
    maxLines: 1,
  );
}

Widget textST1(String text,
    {TextStyle textstyle, FontWeight fontWeight, int maxLines}) {
  return AutoSizeText(
    text,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500, height: 1.3, fontSize: 15),
    maxLines: maxLines ?? 1,
  );
}

Widget textST2(String text,
    {TextStyle textstyle, FontWeight fontWeight, int maxLines}) {
  return AutoSizeText(
    text,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500, fontSize: 14),
    maxLines: maxLines ?? 1,
  );
}

Widget textST3(String text,
    {TextStyle textstyle,
    FontWeight fontWeight,
    double fontSize,
    int maxLines}) {
  return AutoSizeText(
    text,
    minFontSize: 10,
    style: textstyle.copyWith(
        fontWeight: fontWeight ?? FontWeight.w400, fontSize: fontSize ?? 12),
    maxLines: maxLines ?? 1,
  );
}
