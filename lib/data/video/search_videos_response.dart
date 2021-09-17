import 'dart:convert';

import 'package:naprimer_app_v2/data/video/video_item.dart';

SearchVideosResponse searchVideosResponseFromJson(String str, String baseUrl) =>
    SearchVideosResponse.fromJson(json.decode(str),baseUrl);

class SearchVideosResponse {
  SearchVideosResponse({
    required this.videos,
    required this.limit,
    required this.next,
  });

  List<VideoItem> videos;
  int limit;
  dynamic next;

  factory SearchVideosResponse.fromJson(Map<String, dynamic> json, String baseUrl) =>
      SearchVideosResponse(
        videos: List<VideoItem>.from(
            json["results"].map((x) => VideoItem.fromJson(x, baseUrl))),
        limit: json["limit"],
        next: json["next"],
      );
}
