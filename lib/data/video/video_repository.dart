import 'dart:async';

import 'package:get/get_connect.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/data/exception/like_exception.dart';
import 'package:naprimer_app_v2/data/exception/video_exception.dart';
import 'package:naprimer_app_v2/data/video/fetch_videos_response.dart';
import 'package:naprimer_app_v2/data/video/search_videos_response.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/domain/video/abstract_video_repository.dart';
import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';
import 'package:naprimer_app_v2/services/networking/network_service.dart';

class VideoRepository implements AbstractVideoRepository {
  final NetworkService networkService;
  final VideoConfig config;

  VideoRepository({required this.networkService, required this.config});

  //todo itemCtn doesn't work, check backend
  @override
  Future<FetchVideosResponse> fetchVideos(
      {int itemCnt = 10, int? nextIndex, bool isRebuild = false}) async {
    Response response = await networkService.makeRequest(
      requestMethod: RequestMethod.GET,
      url: '${config.fetchVideos}',
      body: {
        'limit': itemCnt,
        'next': nextIndex?.toString() ?? '',
        'rebuild': isRebuild.toString()
      },
    );
    if (response.statusCode != 200) {
      throw FetchVideosException.fromResponse(response);
    }
    return FetchVideosResponse.fromJson(response.body, config.baseUrl);
  }

  @override
  Future<FetchVideosResponse> fetchUserVideos(
      {required String userId, int limit = 10, String nextIndex = ''}) async {
    Response response = await networkService.makeRequest(
      requestMethod: RequestMethod.GET,
      url: '${config.fetchUserVideos(userId)}',
      body: {
        'next': nextIndex,
        'limit': limit,
      },
    );
    if (response.statusCode != 200) {
      throw FetchVideosException.fromResponse(response);
    }
    return FetchVideosResponse.fromJson(response.body, config.baseUrl);
  }

  @override
  Future<void> toggleLikeVideo(
      {required String id, required bool isLiked}) async {
    Response response = await networkService.makeRequest(
        url: config.likeVideo(id),
        requestMethod: isLiked ? RequestMethod.POST : RequestMethod.DELETE);
    if (response.statusCode == 200 || response.statusCode == 204) {
    } else {
      throw LikeException.fromResponse(response);
    }
  }

  //todo fix so video repo should return only response objects
  @override
  Future<List<VideoItem>> fetchLikedVideos(
      {required String userId, String next = '', int limit = 10}) async {
    Response response = await networkService.makeRequest(
        url: '/profiles/$userId/reactions',
        //todo for debug purposes
        query: {'limit': limit.toString(), 'next': next, 'type': 'likes'},
        requestMethod: RequestMethod.GET);
    if (response.body['results'] != null) {
      List<dynamic> jsonList = response.body['results'];
      return jsonList
          .map((json) => VideoItem.fromJson(json, config.baseUrl))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<SearchVideosResponse> search(
      {required String text, String? next}) async {
    Response response = await networkService.makeRequest(
        url: config.searchVideos,
        query: {'text': text, 'limit': '10', 'next': next ?? ''},
        requestMethod: RequestMethod.GET);
    if (response.statusCode != 200) {
      throw FetchVideosException.fromResponse(response);
    }
    return SearchVideosResponse.fromJson(response.body, config.baseUrl);
  }
}
