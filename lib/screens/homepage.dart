import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snackbar_content/flutter_snackbar_content.dart';
import 'package:lottie/lottie.dart';
import 'package:ytshare/constants/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ytshare/model/youtube_data_model.dart';
import 'package:ytshare/screens/video_details.dart';
import 'package:ytshare/screens/settings.dart';
import 'package:ytshare/services/youtube_api_service.dart';

List<YouTubeModel> yt = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDarkMode = false;

  String url = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      updateSystemNavigationBar();
    });
  }

  void updateSystemNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.light : Brightness.dark,
    ));
  }

  String extractVideoId(String url) {
    RegExp regExp = RegExp(
        r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

    Match? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      return 'Invalid YouTube URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
        title: Text(
          Global.appName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.pushNamed(
                context,
                Settings.routeName,
              );
            },
            child: Icon(MdiIcons.cogOutline),
          ),
          const Padding(padding: EdgeInsets.all(8))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Y',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Global.appName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Developed by Nabinoy Baroi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Lottie.asset(
                      'assets/lottie/homepage-animation.json',
                      animate: true,
                      frameRate: FrameRate.max,
                    ),
                  ),
                  const Text(
                    "Welcome to YT Share",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    "Share YouTube video links on your favorite social media platforms with personalized stickers.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter YouTube URL';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter YouTube URL',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        onChanged: (value) => setState(() {
                          url = value;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      String youtubeVideoId = extractVideoId(url);

                      getVideoInfo(youtubeVideoId).then((value) {
                        yt = value;
                        if (yt.isEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          const snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: FlutterSnackbarContent(
                              message: 'Please enter a valid YouTube URL!',
                              contentType: ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          setState(() {
                            isLoading = false;
                          });

                          Navigator.pushNamed(context, VideoDetails.routeName,
                              arguments: yt);
                        }
                      });
                    }
                  },
                  color: Colors.lightBlue[800],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeCap: StrokeCap.round,
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
