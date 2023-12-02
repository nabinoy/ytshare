import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snackbar_content/flutter_snackbar_content.dart';
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
      drawer: const Drawer(
        child: Column(
          children: [],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Random text Lorem ipsum",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Login to your account with some dummy text lorem ipsum dolor.",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
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

                              Navigator.pushNamed(
                                  context, VideoDetails.routeName,
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
                            )
                          : const Text(
                              "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
