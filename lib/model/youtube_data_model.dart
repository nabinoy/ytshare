class YouTubeModel {
  String kind;
  String etag;
  String id;
  Snippet snippet;
  ContentDetails contentDetails;
  Statistics statistics;

  YouTubeModel(
      {required this.kind,
      required this.etag,
      required this.id,
      required this.snippet,
      required this.contentDetails,
      required this.statistics});

  factory YouTubeModel.fromJson(Map<String, dynamic> json) {
    return YouTubeModel(
      kind: json['kind'],
      etag: json['etag'],
      id: json['id'],
      snippet: Snippet.fromJson(json['snippet']),
      contentDetails: ContentDetails.fromJson(json['contentDetails']),
      statistics: Statistics.fromJson(json['statistics']),
    );
  }
}

class Snippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String categoryId;
  String liveBroadcastContent;
  Localized localized;

  Snippet(
      {required this.publishedAt,
      required this.channelId,
      required this.title,
      required this.description,
      required this.thumbnails,
      required this.channelTitle,
      required this.categoryId,
      required this.liveBroadcastContent,
      required this.localized});

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
        publishedAt: json['publishedAt'],
        channelId: json['channelId'],
        title: (json['title'] == null) ? 'No title' : json['title'],
        description: (json['description'] == null)
            ? 'No description'
            : json['description'],
        thumbnails: Thumbnails.fromJson(json['thumbnails']),
        channelTitle: json['channelTitle'],
        categoryId: json['categoryId'],
        liveBroadcastContent: json['liveBroadcastContent'],
        localized: Localized.fromJson(json['localized']));
  }
}

class Thumbnails {
  ThumbnailType default2;
  ThumbnailType medium;
  ThumbnailType high;
  ThumbnailType standard;
  ThumbnailType maxres;

  Thumbnails(
      {required this.default2,
      required this.medium,
      required this.high,
      required this.standard,
      required this.maxres});

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return Thumbnails(
        default2: ThumbnailType.fromJson(json['default']),
        medium: ThumbnailType.fromJson(json['medium']),
        high: ThumbnailType.fromJson(json['high']),
        standard: ThumbnailType.fromJson(json['standard']),
        maxres: (json['maxres'] == null)
            ? (json['standard'] == null)
                ? ThumbnailType.fromJson(json['high'])
                : ThumbnailType.fromJson(json['standard'])
            : ThumbnailType.fromJson(json['maxres']));
  }
}

class ThumbnailType {
  String url;
  int width;
  int height;

  ThumbnailType({required this.url, required this.width, required this.height});

  factory ThumbnailType.fromJson(Map<String, dynamic> json) {
    return ThumbnailType(
        url: json['url'], width: json['width'], height: json['height']);
  }
}

class Localized {
  String title;
  String description;

  Localized({required this.title, required this.description});

  factory Localized.fromJson(Map<String, dynamic> json) {
    return Localized(title: json['title'], description: json['description']);
  }
}

class ContentDetails {
  String duration;
  String dimension;
  String definition;
  String caption;
  bool licensedContent;
  String projection;

  ContentDetails(
      {required this.duration,
      required this.dimension,
      required this.definition,
      required this.caption,
      required this.licensedContent,
      required this.projection});

  factory ContentDetails.fromJson(Map<String, dynamic> json) {
    return ContentDetails(
        duration: json['duration'],
        dimension: json['dimension'],
        definition: json['definition'],
        caption: json['caption'],
        licensedContent: json['licensedContent'],
        projection: json['projection']);
  }
}

class Statistics {
  String viewCount;
  String likeCount;
  String favoriteCount;
  String commentCount;

  Statistics(
      {required this.viewCount,
      required this.likeCount,
      required this.favoriteCount,
      required this.commentCount});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
        viewCount: json['viewCount'],
        likeCount: json['likeCount'],
        favoriteCount: json['favoriteCount'],
        commentCount:
            (json['commentCount'] == null) ? '0' : json['commentCount']);
  }
}
