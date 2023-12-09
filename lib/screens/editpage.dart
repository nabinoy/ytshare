import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:ytshare/constants/global.dart';
import 'package:ytshare/model/youtube_data_model.dart';
import 'package:ytshare/widgets/design0.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/editpage';
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  double _widgetSize = 45.0;
  Color bgColor = Colors.grey;
  int tabValue = 0;
  int selectedDesign = 0;
  bool isHidden = false;
  bool isBgImage = true;

  GlobalKey globalKey = GlobalKey();
  WidgetsToImageController controller = WidgetsToImageController();

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
          "Edit",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14.0),
            child: MaterialButton(
              minWidth: 50,
              height: 30,
              onPressed: () async {
                HapticFeedback.mediumImpact();
                final tempDir = await getTemporaryDirectory();

                final bytes = await controller.capture();

                final file = await File('${tempDir.path}/youtube-share.png')
                    .writeAsBytes(bytes!);
                await Share.shareFiles([file.path], text: 'Watch now!');
              },
              color: Colors.lightBlue[800],
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Share",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(
                    MdiIcons.share,
                    color: Colors.white,
                    size: 18,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetsToImage(
              controller: controller,
              child: (selectedDesign == 0)
                  ? Design0(_widgetSize, bgColor, isHidden, isBgImage, (value) {
                      setState(() {
                        isBgImage = value;
                      });
                    }, (value) {
                      setState(() {
                        isHidden = value;
                      });
                    }, (value) {
                      setState(() {
                        _widgetSize = value;
                      });
                    }, (value) {
                      setState(() {
                        bgColor = value;
                      });
                    })
                  : Stack(alignment: Alignment.center, children: [
                      Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: MediaQuery.of(context).size.width * 0.6),
                      SizedBox(
                        width: _widgetSize,
                        height: _widgetSize,
                        child: Container(
                          color: Colors.blue,
                          child: Text(
                            'Textb',
                            style: TextStyle(fontSize: _widgetSize * 0.4),
                          ),
                        ),
                      )
                    ]),
            ),
            Column(
              children: [
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: Global.fontRegular),
                    unselectedLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w100,
                        fontFamily: Global.fontRegular),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerHeight: 0,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    tabs: const [
                      Tab(text: 'Design'),
                      Tab(text: 'Selection'),
                      Tab(text: 'Background'),
                      Tab(text: 'Size'),
                    ],
                    onTap: (value) {
                      setState(() {
                        tabValue = value;
                      });
                    },
                  ),
                ),
                TabContent(tabValue, _widgetSize, isHidden, isBgImage, (value) {
                  setState(() {
                    isBgImage = value;
                  });
                }, (value) {
                  setState(() {
                    isHidden = value;
                  });
                }, (value) {
                  setState(() {
                    _widgetSize = value;
                  });
                }, (value) {
                  setState(() {
                    selectedDesign = value;
                  });
                }, (value) {
                  setState(() {
                    bgColor = value;
                  });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatefulWidget {
  final int tabName;
  final double widgetSize;
  final bool isHidden;
  final bool isBgImage;
  final ValueChanged<bool> onBgChanged;
  final ValueChanged<bool> onSwitchChanged;
  final ValueChanged<double> onSizeChanged;
  final ValueChanged<int> onDesignChanged;
  final ValueChanged<Color> onColorChanged;

  const TabContent(
      this.tabName,
      this.widgetSize,
      this.isHidden,
      this.isBgImage,
      this.onBgChanged,
      this.onSwitchChanged,
      this.onSizeChanged,
      this.onDesignChanged,
      this.onColorChanged,
      {super.key});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;
  bool isSelected5 = false;
  bool isSelected6 = false;

  @override
  Widget build(BuildContext context) {
    List<YouTubeModel> youtubeInfo =
        ModalRoute.of(context)!.settings.arguments as List<YouTubeModel>;
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ((widget.tabName == 0))
          ? Row(children: [
              MaterialButton(
                minWidth: 60,
                height: 60,
                onPressed: () {
                  setState(() {
                    widget.onDesignChanged(0);
                  });
                },
                color: Colors.lightBlue[800],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "Design 1",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              MaterialButton(
                minWidth: 60,
                height: 60,
                onPressed: () {
                  setState(() {
                    widget.onDesignChanged(1);
                  });
                },
                color: Colors.lightBlue[800],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "Design 2",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ])
          : (widget.tabName == 1)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Hide likes, views and comments count',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status:  ${widget.isHidden ? 'Hidden' : 'Visible'}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Switch(
                            activeColor: Colors.lightBlue[700],
                            activeTrackColor: Colors.grey.shade400,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                            value: widget.isHidden,
                            onChanged: (value) {
                              setState(() {
                                widget.onSwitchChanged(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : (widget.tabName == 2)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.onBgChanged(true);
                                  isSelected1 = true;
                                  isSelected2 = false;
                                  isSelected3 = false;
                                  isSelected4 = false;
                                  isSelected5 = false;
                                  isSelected6 = false;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: isSelected1
                                        ? Colors.lightBlue[800] as Color
                                        : Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          filterQuality: FilterQuality.high,
                                          alignment: Alignment.center,
                                          imageUrl: youtubeInfo.first.snippet
                                              .thumbnails.maxres.url,
                                          placeholder: (context, url) =>
                                              Image.memory(
                                            kTransparentImage,
                                            fit: BoxFit.cover,
                                          ),
                                          fadeInDuration:
                                              const Duration(milliseconds: 200),
                                          fit: BoxFit.cover,
                                        ),
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                              tileMode: TileMode.mirror,
                                              sigmaX: 10,
                                              sigmaY: 10),
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: isSelected2
                                      ? Colors.lightBlue[800] as Color
                                      : Theme.of(context).colorScheme.primary,
                                  width: 3.0,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  onPressed: () {
                                    setState(() {
                                      widget.onColorChanged(Colors.lightBlue);
                                      widget.onBgChanged(false);
                                      isSelected2 = true;
                                      isSelected1 = false;
                                      isSelected3 = false;
                                      isSelected4 = false;
                                      isSelected5 = false;
                                      isSelected6 = false;
                                    });
                                  },
                                  color: Colors.lightBlue,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    "",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: isSelected3
                                      ? Colors.lightBlue[800] as Color
                                      : Theme.of(context).colorScheme.primary,
                                  width: 3.0,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  onPressed: () {
                                    setState(() {
                                      widget.onColorChanged(Colors.red);
                                      widget.onBgChanged(false);
                                      isSelected3 = true;
                                      isSelected2 = false;
                                      isSelected1 = false;
                                      isSelected4 = false;
                                      isSelected5 = false;
                                      isSelected6 = false;
                                    });
                                  },
                                  color: Colors.red,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    "",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: isSelected4
                                      ? Colors.lightBlue[800] as Color
                                      : Theme.of(context).colorScheme.primary,
                                  width: 3.0,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  onPressed: () {
                                    setState(() {
                                      widget.onColorChanged(Colors.grey);
                                      widget.onBgChanged(false);
                                      isSelected4 = true;
                                      isSelected1 = false;
                                      isSelected2 = false;
                                      isSelected3 = false;
                                      isSelected5 = false;
                                      isSelected6 = false;
                                    });
                                  },
                                  color: Colors.grey,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    "",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: isSelected5
                                      ? Colors.lightBlue[800] as Color
                                      : Theme.of(context).colorScheme.primary,
                                  width: 3.0,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  onPressed: () {
                                    setState(() {
                                      widget.onColorChanged(Colors.green);
                                      widget.onBgChanged(false);
                                      isSelected5 = true;
                                      isSelected1 = false;
                                      isSelected2 = false;
                                      isSelected3 = false;
                                      isSelected4 = false;
                                      isSelected6 = false;
                                    });
                                  },
                                  color: Colors.green,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    "",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: isSelected6
                                      ? Colors.lightBlue[800] as Color
                                      : Theme.of(context).colorScheme.primary,
                                  width: 3.0,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  onPressed: () {
                                    setState(() {
                                      widget.onColorChanged(Colors.pink);
                                      widget.onBgChanged(false);
                                      isSelected6 = true;
                                      isSelected1 = false;
                                      isSelected2 = false;
                                      isSelected3 = false;
                                      isSelected4 = false;
                                      isSelected5 = false;
                                    });
                                  },
                                  color: Colors.pink,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    "",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (widget.tabName == 3)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Size: ${widget.widgetSize.toInt()}'),
                            Slider(
                              value: widget.widgetSize,
                              min: 30,
                              max: 60,
                              thumbColor: Colors.lightBlue[600],
                              activeColor: Colors.lightBlue[600],
                              onChanged: (value) {
                                setState(() {
                                  widget.onSizeChanged(value);
                                });
                              },
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Content foreeee ${widget.tabName}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Selected Tab: ${widget.tabName}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
    );
  }
}
