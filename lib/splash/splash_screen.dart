import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<PageTransition> loadFromFuture() async {
  //   return PageTransition(
  //     child: const Home(),
  //     type: PageTransitionType.fade,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    //SharedService.shareInit();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return AnimatedSplashScreen(
        curve: Curves.easeIn,
        duration: 3000,
        splashIconSize: 600,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Animate(
                  effects: [
                    FadeEffect(duration: 1000.ms),
                    ShimmerEffect(delay: 800.ms, duration: 1500.ms),
                    ScaleEffect(
                        duration: 800.ms, curve: Curves.fastEaseInToSlowEaseOut)
                  ],
                  child: SizedBox(
                    height: 150,
                    width: 250,
                    child: Image.asset('assets/images/tripify_logo.png'),
                  ),
                ),
                Animate(
                  effects: [
                    FadeEffect(duration: 500.ms, delay: 1000.ms),
                    SlideEffect(duration: 800.ms, curve: Curves.elasticOut)
                  ],
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      Global.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.2,
                        color: Colors.lightBlue[800],
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        nextScreen: const Home(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white);
  }
}
