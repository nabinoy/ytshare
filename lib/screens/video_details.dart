import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:ytshare/model/youtube_data_model.dart';
import 'package:ytshare/util/image_viewer.dart';

class VideoDetails extends StatefulWidget {
  static const String routeName = '/videodetails';
  const VideoDetails({super.key});

  @override
  State<VideoDetails> createState() => _DetailsState();
}

class _DetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    List<YouTubeModel> youtubeInfo =
        ModalRoute.of(context)!.settings.arguments as List<YouTubeModel>;

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
          "Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
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
                      child: Hero(
                        tag: youtubeInfo.first.snippet.thumbnails.maxres.url,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: CachedNetworkImage(
                              alignment: Alignment.bottomCenter,
                              imageUrl: youtubeInfo
                                  .first.snippet.thumbnails.maxres.url,
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
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      youtubeInfo.first.snippet.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
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
                        Text(
                          youtubeInfo.first.snippet.channelTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              youtubeInfo.first.statistics.likeCount,
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
                        Column(
                          children: [
                            Text(
                              youtubeInfo.first.statistics.viewCount,
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
                        Column(
                          children: [
                            Text(
                              youtubeInfo.first.statistics.commentCount,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ExpandableText(
                  youtubeInfo.first.snippet.description,
                  animation: true,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 7,
                  linkColor: Colors.lightBlue[800],
                ),
              ),
              Text('Dimension:  ${youtubeInfo.first.contentDetails.dimension}'),
              Text(
                  'Definition:  ${youtubeInfo.first.contentDetails.definition}'),
            ],
          ),
        ),
      ),
    );
  }
}
