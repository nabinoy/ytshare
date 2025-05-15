import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/router.dart';
import 'package:ytshare/services/shared_service.dart';
import 'package:ytshare/splash/splash_screen.dart';
import 'package:ytshare/theme/theme.dart';
import 'package:ytshare/theme/theme_provider.dart';

import 'package:ytshare/screens/settings.dart';
import 'dart:async';

void main() {
  //runApp(const YTShare());
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const YTShare(),
  ));
}

class YTShare extends StatefulWidget {
  const YTShare({super.key});

  @override
  State<YTShare> createState() => _YTShareState();
}

class _YTShareState extends State<YTShare> {
  int themeOrder = 0;
  late StreamSubscription _intentDataStreamSubscription;
  List<SharedFile>? list;

  @override
  void initState() {
    super.initState();
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = FlutterSharingIntent.instance.getMediaStream()
        .listen((List<SharedFile> value) {
      setState(() {
        list = value;
        print("LIST: $list");
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance.getInitialSharing().then((List<SharedFile> value) {
      setState(() {
        list = value;
        print("LIST: $list");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  Future<void> futureCall() async {
    themeOrder = await SharedService.getThemeOrder();
    if (themeOrder==2) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor:
                    Colors.grey.shade300,
            systemNavigationBarIconBrightness:Brightness.dark,
          ));
    }
    if (themeOrder == 3) {
        // ignore: use_build_context_synchronously
        Provider.of<ThemeProvider>(context, listen: false).darkTheme(true);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.grey.shade900,
            systemNavigationBarIconBrightness:Brightness.light
          ));
      }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: (() async {
      return await futureCall();
    })(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (themeOrder == 1) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor:
                (MediaQuery.of(context).platformBrightness == Brightness.dark)
                    ? Colors.grey.shade900
                    : Colors.grey.shade300,
            systemNavigationBarIconBrightness:
                (MediaQuery.of(context).platformBrightness == Brightness.dark)
                    ? Brightness.light
                    : Brightness.dark,
          ));
          return MaterialApp(
            title: Global.appName,
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            onGenerateRoute: (settings) => generateRoute(settings),
            // home: const SplashScreen(),
            home: (list != null && list!.isNotEmpty)
          ? const Settings()
          : const SplashScreen()
          );
        } else {
          return MaterialApp(
            title: Global.appName,
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            // theme: ThemeData(
            //   fontFamily: Global.fontRegular,
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //   useMaterial3: true,
            // ),
            onGenerateRoute: (settings) => generateRoute(settings),
            //home: const Settings(),
            home: (list != null && list!.isNotEmpty)
          ? const Settings()
          : const SplashScreen()
          );
        }
      } else {
        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }
    });
  }
}
