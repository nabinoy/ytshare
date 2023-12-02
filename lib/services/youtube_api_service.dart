import 'dart:convert';

import 'package:ytshare/constants/config.dart';
import 'package:http/http.dart' as http;
import 'package:ytshare/model/youtube_data_model.dart';

Future<List<YouTubeModel>> getVideoInfo(String videoId) async {
  final uri = Uri.parse(
      'https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=${Config.youtubeAPI}&part=snippet,contentDetails,statistics');
  var response = await http.get(uri);

  if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data = data['items'];
      List<YouTubeModel> y = [];

      for (var i = 0; i < data.length; i++) {
        YouTubeModel yt = YouTubeModel.fromJson(data[i]);
        y.add(yt);
      }
      return y;
    } else {
      throw Exception('Failed to load YouTube video details');
    }
}
