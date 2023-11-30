import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/router.dart';
import 'package:ytshare/splash/splash_screen.dart';
//import 'package:ytshare/theme/theme.dart';
import 'package:ytshare/theme/theme_provider.dart';

void main() {
  //runApp(const YTShare());
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const YTShare(),
  ));
}

class YTShare extends StatelessWidget {
  const YTShare({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: Global.appName,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // theme: lightMode,
      //darkTheme: darkMode,
      // theme: ThemeData(
      //   fontFamily: Global.fontRegular,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
