import 'package:flutter/material.dart';
import 'style.dart';

final appLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: bgPrimaryColor0,
    inversePrimary: Colors.white,
    outline: Colors.black,
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
  ),
);
