import 'package:flutter/material.dart';
import 'style.dart';

final appLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white, // màu nền chính
    primary: Colors.black, //màu chữ chính
    secondary: bgPrimaryColor0, //màu nền phụ
    inversePrimary: Colors.white, //màu
    outline: Colors.black, //màu viền
    onBackground: Colors.white, //màu ô
    onPrimaryContainer: appPrimaryColor, // màu
  ),
);

final appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: bgPrimaryColor1,
    inversePrimary: bgPrimaryColor1,
    outline: Colors.white,
    onBackground: Colors.transparent,
    onPrimaryContainer: Colors.white, // màu
  ),
);
