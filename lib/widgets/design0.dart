import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:ytshare/model/youtube_data_model.dart';

class Design0 extends StatefulWidget {
  final double widgetSize;
  final Color bgColor;
  final bool isHidden;
  final bool isBgImage;
  final bool isBWBgImage;
  final double blurValue;
  final ValueChanged<double> onBlurValueChanged;
  final ValueChanged<bool> onBWBgChanged;
  final ValueChanged<bool> onBgChanged;
  final ValueChanged<double> onSizeChanged;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<bool> onSwitchChanged;

  const Design0(
      this.widgetSize,
      this.bgColor,
      this.isHidden,
      this.isBgImage,
      this.isBWBgImage,
      this.blurValue,
      this.onBlurValueChanged,
      this.onBWBgChanged,
      this.onBgChanged,
      this.onSwitchChanged,
      this.onSizeChanged,
      this.onColorChanged,
      {super.key});

  @override
  State<Design0> createState() => _Design0State();
}

class _Design0State extends State<Design0> {
  String formatNumberAbbreviated(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '$number';
    }
  }

  String formatDuration(String durationString) {
    durationString = durationString.replaceAll("PT", "");

    if (durationString.contains("H")) {
      List<String> parts = durationString.split("H");

      int hours = int.parse(parts[0]);
      int minutes =
          parts[1].contains("M") ? int.parse(parts[1].split("M")[0]) : 0;
      int seconds = parts[1].contains("S")
          ? int.parse(parts[1].split("M")[1].replaceAll("S", ""))
          : 0;

      return '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    } else if (durationString.contains("M")) {
      List<String> parts = durationString.split("M");

      int minutes = int.parse(parts[0]);
      int seconds =
          parts[1].contains("S") ? int.parse(parts[1].replaceAll("S", "")) : 0;

      return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    } else {
      int seconds = int.parse(durationString.replaceAll("S", ""));
      return '0:${_twoDigits(seconds)}';
    }
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    List<YouTubeModel> youtubeInfo =
        ModalRoute.of(context)!.settings.arguments as List<YouTubeModel>;
    return Stack(alignment: Alignment.center, children: [
      (widget.isBgImage == true)
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        (widget.isBWBgImage == true)
                            ? Colors.black
                            : Colors.transparent,
                        BlendMode.saturation,
                      ),
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.high,
                        alignment: Alignment.center,
                        imageUrl:
                            youtubeInfo.first.snippet.thumbnails.maxres.url,
                        placeholder: (context, url) => Image.memory(
                          kTransparentImage,
                          fit: BoxFit.cover,
                        ),
                        fadeInDuration: const Duration(milliseconds: 200),
                        fit: BoxFit.cover,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          tileMode: TileMode.mirror,
                          sigmaX: widget.blurValue,
                          sigmaY: widget.blurValue),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.6),
      Container(
        width: widget.widgetSize * 3.8,
        padding: EdgeInsets.all(widget.widgetSize * 0.15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: (0.4 * 255)),
          borderRadius: BorderRadius.circular(widget.widgetSize * 0.14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: youtubeInfo.first.snippet.thumbnails.maxres.url,
                  child: SizedBox(
                    width: widget.widgetSize * 4,
                    height: widget.widgetSize * 2,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.widgetSize * 0.13),
                      child: CachedNetworkImage(
                        alignment: Alignment.center,
                        imageUrl:
                            youtubeInfo.first.snippet.thumbnails.maxres.url,
                        placeholder: (context, url) => Image.memory(
                          kTransparentImage,
                          fit: BoxFit.cover,
                        ),
                        fadeInDuration: const Duration(milliseconds: 200),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: widget.widgetSize * 0.08,
                  bottom: widget.widgetSize * 0.08,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: widget.widgetSize * 0.02,
                        horizontal: widget.widgetSize * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: (0.6 * 255)),
                      borderRadius:
                          BorderRadius.circular(widget.widgetSize * 0.065),
                    ),
                    child: Text(
                      formatDuration(youtubeInfo.first.contentDetails.duration),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.widgetSize * 0.14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.widgetSize * 0.16,
            ),
            Text(
              youtubeInfo.first.snippet.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: widget.widgetSize * 0.21,
              ),
            ),
            SizedBox(
              height: widget.widgetSize * 0.08,
            ),
            Row(
              children: [
                Icon(
                  MdiIcons.youtube,
                  size: widget.widgetSize * 0.23,
                ),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: widget.widgetSize * 2,
                  child: Text(
                    youtubeInfo.first.snippet.channelTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: widget.widgetSize * 0.16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.widgetSize * 0.12,
            ),
            (widget.isHidden == true)
                ? const SizedBox(
                    height: 0,
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              formatNumberAbbreviated(int.parse(
                                  youtubeInfo.first.statistics.likeCount)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.widgetSize * 0.2,
                              ),
                            ),
                            Text(
                              'Likes',
                              style:
                                  TextStyle(fontSize: widget.widgetSize * 0.13),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.widgetSize * 0.16,
                        ),
                        Column(
                          children: [
                            Text(
                              formatNumberAbbreviated(int.parse(
                                  youtubeInfo.first.statistics.viewCount)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.widgetSize * 0.2,
                              ),
                            ),
                            Text(
                              'Views',
                              style:
                                  TextStyle(fontSize: widget.widgetSize * 0.13),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.widgetSize * 0.16,
                        ),
                        Column(
                          children: [
                            Text(
                              formatNumberAbbreviated(int.parse(
                                  youtubeInfo.first.statistics.commentCount)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.widgetSize * 0.2,
                              ),
                            ),
                            Text(
                              'Comments',
                              style:
                                  TextStyle(fontSize: widget.widgetSize * 0.13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: widget.widgetSize * 0.12,
            ),
            Opacity(
              opacity: 0.8,
              child:
                  (Theme.of(context).colorScheme.brightness == Brightness.light)
                      ? Image.asset('assets/images/Youtube-logo-dark.png',
                          width: widget.widgetSize * 0.8,
                          height: widget.widgetSize * 0.3)
                      : Image.asset('assets/images/Youtube-logo-light.png',
                          width: widget.widgetSize * 0.8,
                          height: widget.widgetSize * 0.3),
            )
          ],
        ),
      ),
    ]);
  }
}
