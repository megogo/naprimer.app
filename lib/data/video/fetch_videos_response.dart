import 'dart:convert';

import 'package:naprimer_app_v2/data/video/video_item.dart';

FetchVideosResponse fetchVideosResponseFromJson(String str, String baseUrl) =>
    FetchVideosResponse.fromJson(json.decode(str),baseUrl);

class FetchVideosResponse {
  FetchVideosResponse({
    required this.videos,
    required this.limit,
    required this.next,
  });

  List<VideoItem> videos;
  int limit;
  dynamic next;

  factory FetchVideosResponse.fromJson(Map<String, dynamic> json, String baseUrl) =>
      FetchVideosResponse(
        videos: List<VideoItem>.from(
            json["results"].map((x) => VideoItem.fromJson(x, baseUrl))),
        limit: json["limit"],
        next: json["next"],
      );
}
