import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Title:  ${youtubeInfo.first.snippet.title}'),
              Text('Description:  ${youtubeInfo.first.snippet.description}'),
              Text('Channel title:  ${youtubeInfo.first.snippet.channelTitle}'),
              Text('Dimension:  ${youtubeInfo.first.contentDetails.dimension}'),
              Text(
                  'Definition:  ${youtubeInfo.first.contentDetails.definition}'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(
                          imagePath:
                              youtubeInfo.first.snippet.thumbnails.maxres.url),
                    ),
                  );
                },
                child: Hero(
                  tag: youtubeInfo.first.snippet.thumbnails.maxres.url,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 356,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        height: 430,
                        alignment: Alignment.bottomCenter,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
