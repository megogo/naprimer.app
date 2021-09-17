import 'package:get/get.dart';
import 'package:naprimer_app_v2/data/video/fetch_videos_response.dart';
import 'package:naprimer_app_v2/data/video/search_videos_response.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/data/video/video_repository.dart';

class VideoController extends GetxController {
  late VideoRepository _videoRepository;
  late Map<String, VideoItem> _likedVideos;

  List<VideoItem> get likedVideos =>
      _likedVideos.entries.map((entry) => entry.value).toList();

  @override
  void onInit() {
    _videoRepository = Get.find<VideoRepository>();
    _likedVideos = {};
    super.onInit();
  }

  Future<void> fetchLikedVideos(
      {required String userId, String next = '', int limit = 10}) async {
    List<VideoItem> list = await _videoRepository.fetchLikedVideos(
        userId: userId, next: next, limit: limit);
    _likedVideos = Map.fromIterable(list, key: (k) => k.id, value: (v) => v);
  }

  Future<List<VideoItem>> fetchUserLikedVideos(
      {required String userId, String next = '', int limit = 10}) async {
    List<VideoItem> list = await _videoRepository.fetchLikedVideos(
        userId: userId, next: next, limit: limit);
    return list;
  }

  Future<FetchVideosResponse> fetchVideos(
      {int itemCnt = 10, int? nextIndex, bool isRebuild = false}) async {
    FetchVideosResponse videoResponse = await _videoRepository.fetchVideos(
        itemCnt: itemCnt, nextIndex: nextIndex, isRebuild: isRebuild);
    return videoResponse;
  }

  bool isVideoLiked(String id) {
    return _likedVideos[id] != null;
  }

  Future<dynamic> toggleLikeVideo(
      {required VideoItem video, required bool isLiked}) async {
    await _videoRepository.toggleLikeVideo(id: video.id, isLiked: isLiked);
    if (isLiked) {
      _likedVideos[video.id] = video;
    } else {
      _likedVideos.remove(video.id);
    }
  }

  void clearFetchedVideos() {
    _likedVideos.clear();
  }

  Future<SearchVideosResponse> searchVideos(
      {required String text, String? next}) async {
    SearchVideosResponse response =
        await _videoRepository.search(text: text, next: next);
    return response;
  }

  Future<FetchVideosResponse> fetchUserVideos({ required String userId, String next = '', int limit = 10}) async{
    FetchVideosResponse videoResponse = await _videoRepository.fetchUserVideos(
      userId: userId, limit: limit, nextIndex: next);
    return videoResponse;
  }

}
//
// Future<ResponseListResult> getUserVideos(String userId,
//     {String next = '', int limit = 10}) =>
//     _getVideos(
//         '${Hosts.mainApi}/profiles/$userId/videos', userId, next, limit,
//         query: {'sort': '-released_at'});
