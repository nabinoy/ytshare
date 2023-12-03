import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ytshare/services/shared_service.dart';
import 'package:ytshare/theme/theme_provider.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/settings';
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedValue = 1;

  Future<void> futureCall() async {
    selectedValue = await SharedService.getThemeOrder();
  }

  void darkTheme(bool data) {
    setState(() {
      updateSystemNavigationBar(data);
    });
  }

  void updateSystemNavigationBar(bool data) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          data ? Colors.grey.shade900 : Colors.grey.shade300,
      systemNavigationBarIconBrightness:
          data ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(MdiIcons.palette),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    'Appearance',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder(
                  future: Future.wait([futureCall()]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Theme',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Colors.blue,
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                      SharedService.setThemeOrder(
                                          selectedValue);
                                    });
                                  },
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Automatic'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      MdiIcons.alertCircleOutline,
                                      size: 10,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'Any changes requires restart',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  activeColor: Colors.blue,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                      darkTheme(false);
                                      SharedService.setThemeOrder(
                                          selectedValue);
                                      Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .darkTheme(false);
                                    });
                                  },
                                ),
                                const Text('Light'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 3,
                                  activeColor: Colors.blue,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                      darkTheme(true);
                                      SharedService.setThemeOrder(
                                          selectedValue);
                                      Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .darkTheme(true);
                                    });
                                  },
                                ),
                                const Text('Dark'),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Theme',
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: 4,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Automatic'),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      MdiIcons.alertCircleOutline,
                                      size: 10,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'Any changes requires restart',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: 4,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                const Text('Light'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: 4,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                const Text('Dark'),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightBlue[800],
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.pop(context);
        },
        tooltip: 'Done',
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        label: const Text(
          'Done',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
