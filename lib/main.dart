import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/router.dart';
import 'package:ytshare/services/shared_service.dart';
import 'package:ytshare/splash/splash_screen.dart';
import 'package:ytshare/theme/theme.dart';
//import 'package:ytshare/theme/theme.dart';
import 'package:ytshare/theme/theme_provider.dart';

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

  Future<void> futureCall() async {
    themeOrder = await SharedService.getThemeOrder();
    if (themeOrder==2) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor:
                    Colors.grey.shade400,
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
                    : Colors.grey.shade400,
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
            home: const SplashScreen(),
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
            home: const SplashScreen(),
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
