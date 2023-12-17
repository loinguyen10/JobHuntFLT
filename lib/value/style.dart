import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

//text
final textNormal = TextStyle(fontSize: ParameterStyle.FONT_SIZE_NORMAL);
final textNormalBold = TextStyle(
    fontSize: ParameterStyle.FONT_SIZE_NORMAL, fontWeight: FontWeight.bold);
final textNormalHint =
    TextStyle(fontSize: ParameterStyle.FONT_SIZE_NORMAL, color: Colors.grey);
final textCV = TextStyle(
    fontSize: ParameterStyle.FONT_SIZE_NORMAL, fontWeight: FontWeight.bold);
final textCVupload = TextStyle(
    fontSize: ParameterStyle.FONT_SIZE_NORMAL,
    fontWeight: FontWeight.bold,
    color: Colors.red);
final textJobHome = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
final textMenu = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
final textNameMenu = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
final textTitleRole = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
final textLogo =
    TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white);
final textNameVCompany = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
final textNameJView = TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
final textCompanyJView = TextStyle(fontSize: ParameterStyle.FONT_SIZE_NORMAL);
final textTitleJView = TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: appPrimaryColor);
final textTitle2JView = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
final textCompany2JView = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final textCompanyFView = TextStyle(
    fontSize: ParameterStyle.FONT_SIZE_NORMAL, fontWeight: FontWeight.w500);
final textStatusView = TextStyle(
    fontSize: ParameterStyle.FONT_SIZE_NORMAL,
    color: Colors.white,
    fontWeight: FontWeight.bold);
final textStatus2View =
    TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
final textNormal2 =
    TextStyle(fontSize: ParameterStyle.FONT_SIZE_NORMAL, color: Colors.white);
final textTitleTab1Company =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

//color
final appPrimaryColor = Color(0xffff7624);
final appBgGradientColor = Color(0xffff8839);
final bgPrimaryColor0 = Color(0xffEEEEEE);
final bgPrimaryColor1 = Color(0xff404040);
final appHintColor = Color.fromARGB(0, 238, 238, 238);
final bgGradientColor0 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    appPrimaryColor,
    appBgGradientColor,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
);

final bgGradientColor1 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    bgPrimaryColor1,
    bgPrimaryColor1,
  ],
  tileMode: TileMode.mirror,
);

final bgGradientColor2 = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomCenter,
  colors: <Color>[
    appPrimaryColor,
    appBgGradientColor,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
);

final bgGradientColor3 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    appPrimaryColor,
    appBgGradientColor,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
);

final bgGradientColorHome = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    appBgGradientColor,
    appBgGradientColor,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
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

final dropDownButtonStyle2 = ButtonStyleData(
  padding: EdgeInsets.symmetric(horizontal: 8),
  height: 20,
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

class ParameterStyle {
  static const APP_BUTTON_HEIGHT_NORMAL = 56.0;
  static const FONT_SIZE_NORMAL = 16.0;
  static const BORDER_RADIUS_NORMAL = 8.0;
}

class APIStatusCode {
  static const STATUS_CODE_OK = 200;
  static const CODE_SUCCESSFUL = 1;
  static const CODE_UNSUCCESSFUL = 0;
}
