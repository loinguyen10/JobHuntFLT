import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

//text
final textNormal = TextStyle(fontSize: 16);
final textNormalHint = TextStyle(fontSize: 16, color: Colors.grey);
final textCV = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final textCVupload =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
final textJobHome = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
final textMenu = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
final textNameMenu = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

//color
final appPrimaryColor = Color(0xff00A3FF);
final bgPrimaryColor = Color(0xffEEEEEE);
final appHintColor = Color.fromARGB(0, 238, 238, 238);
final bgGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    appPrimaryColor,
    appPrimaryColor,
    Color(0xffA0DDFF),
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
);

//style
final dropDownButtonStyle1 = ButtonStyleData(
  padding: EdgeInsets.symmetric(horizontal: 8),
  height: 32,
  width: 160,
);
final dalDateStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: 16, horizontal: 8)),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey))));
