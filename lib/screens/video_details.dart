import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:ytshare/model/category_model.dart';
import 'package:ytshare/model/youtube_data_model.dart';
import 'package:ytshare/screens/editpage.dart';
import 'package:ytshare/util/image_viewer.dart';

class VideoDetails extends StatefulWidget {
  static const String routeName = '/videodetails';
  const VideoDetails({super.key});

  @override
  State<VideoDetails> createState() => _DetailsState();
}

class _DetailsState extends State<VideoDetails> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/json/youtube_category.json');
  }

  Future loadCategories() async {
    String jsonData = await loadJsonData();
    final jsonResponse = json.decode(jsonData);
    setState(() {
      categories = (jsonResponse['categories'] as List)
          .map((data) => Category.fromJson(data))
          .toList();
    });
  }

  String findCategoryNameById(String id) {
    Category? category = categories.firstWhere(
      (element) => element.id == id,
      orElse: () => Category(id: '', name: 'Others', icon: 'video'),
    );
    return category.name;
  }

  String findCategoryIconById(String id) {
    Category? category = categories.firstWhere(
      (element) => element.id == id,
      orElse: () => Category(id: '', name: 'Others', icon: 'video'),
    );
    return category.icon;
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDateString = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDateString;
  }

  String formatNumber(int number) {
    NumberFormat numberFormat = NumberFormat('##,##,###');
    String formattedNumber = numberFormat.format(number);
    return formattedNumber;
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          "Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewer(
                                imagePath: youtubeInfo
                                    .first.snippet.thumbnails.maxres.url),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Hero(
                            tag:
                                youtubeInfo.first.snippet.thumbnails.maxres.url,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: CachedNetworkImage(
                                  alignment: Alignment.center,
                                  imageUrl: youtubeInfo
                                      .first.snippet.thumbnails.maxres.url,
                                  placeholder: (context, url) => Image.memory(
                                    kTransparentImage,
                                    fit: BoxFit.cover,
                                  ),
                                  fadeInDuration:
                                      const Duration(milliseconds: 200),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  formatDuration(youtubeInfo
                                      .first.contentDetails.duration),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      youtubeInfo.first.snippet.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          MdiIcons.youtube,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            youtubeInfo.first.snippet.channelTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  formatNumber(int.parse(
                                      youtubeInfo.first.statistics.likeCount)),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MdiIcons.thumbUpOutline,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Likes',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                Text(
                                  formatNumber(int.parse(
                                      youtubeInfo.first.statistics.viewCount)),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MdiIcons.playOutline,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'Views',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                Text(
                                  formatNumber(int.parse(youtubeInfo
                                      .first.statistics.commentCount)),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MdiIcons.commentOutline,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Comments',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDateString(youtubeInfo.first.snippet.publishedAt),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ExpandableText(
                      youtubeInfo.first.snippet.description,
                      animation: true,
                      expandText: 'show more',
                      collapseText: 'show less',
                      maxLines: 6,
                      linkColor: Colors.lightBlue[600],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('Definition  ',
                                style: TextStyle(fontSize: 13)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                youtubeInfo.first.contentDetails.definition
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Caption  ',
                                style: TextStyle(fontSize: 13)),
                            (youtubeInfo.first.contentDetails.caption == 'true')
                                ? Icon(
                                    Icons.closed_caption,
                                    color: Colors.red[700],
                                    size: 31,
                                  )
                                : const Icon(
                                    Icons.closed_caption_disabled,
                                    size: 28,
                                  )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.fromString(findCategoryIconById(
                                  youtubeInfo.first.snippet.categoryId)),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              findCategoryNameById(
                                  youtubeInfo.first.snippet.categoryId),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ],
                        ),
                        const Text(
                          'Category',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    Navigator.pushNamed(context, EditPage.routeName,
                        arguments: youtubeInfo);
                  },
                  color: Colors.lightBlue[800],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Proceed",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
