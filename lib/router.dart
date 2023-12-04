import 'package:flutter/material.dart';
import 'package:ytshare/screens/editpage.dart';
import 'package:ytshare/screens/video_details.dart';
import 'package:ytshare/screens/settings.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case EditPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditPage(),
      );

    case Settings.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Settings(),
      );

    case VideoDetails.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VideoDetails(),
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
