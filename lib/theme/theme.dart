import 'package:flutter/material.dart';
import 'package:ytshare/constants/global.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: Global.fontRegular,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade100),
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
