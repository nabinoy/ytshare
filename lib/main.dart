import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    futureCall();
    
  }

  Future<void> futureCall() async {
    themeOrder = await SharedService.getThemeOrder();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: Global.appName,
      debugShowCheckedModeBanner: false,
      theme: (themeOrder==1)? lightMode: Provider.of<ThemeProvider>(context).themeData,
      // theme: lightMode,
      darkTheme: (themeOrder==1)?darkMode:Provider.of<ThemeProvider>(context).themeData,
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
