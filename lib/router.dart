import 'package:flutter/material.dart';
import 'package:ytshare/screens/settings.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Settings.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Settings(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}