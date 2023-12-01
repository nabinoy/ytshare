import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void darkTheme(bool data) {
    setState(() {
      updateSystemNavigationBar(data);
    });
  }

  void updateSystemNavigationBar(bool data) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          data ? Colors.grey.shade900 : Colors.grey.shade400,
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
              Text(
                'Appearance',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                //height: MediaQuery.sizeOf(context).height * 0.10,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        Text('System default'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              darkTheme(false);
                              SharedService.setThemeOrder(selectedValue);
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .darkTheme(false);
                            });
                          },
                        ),
                        Text('Light'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              darkTheme(true);
                              SharedService.setThemeOrder(selectedValue);
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .darkTheme(true);
                            });
                          },
                        ),
                        Text('Dark'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Selected Value: $selectedValue'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
