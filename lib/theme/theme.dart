import 'package:flutter/material.dart';
import 'package:ytshare/constants/global.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: Global.fontRegular,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade200),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: Global.fontRegular,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700),
);
