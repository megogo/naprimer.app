import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/data/video/fetch_videos_response.dart';
import 'package:naprimer_app_v2/data/video/search_videos_response.dart';
import 'package:naprimer_app_v2/domain/video/abstract_video_item.dart';

abstract class AbstractVideoRepository {
  final VideoConfig config;

  AbstractVideoRepository(this.config);

  Future<FetchVideosResponse> fetchVideos();

  Future<FetchVideosResponse> fetchUserVideos(
      {required String userId, int limit = 10, String nextIndex = ''});

  Future<void> toggleLikeVideo({required String id, required bool isLiked});

  Future<List<AbstractVideoItem>> fetchLikedVideos(
      {required String userId, String next = '', int limit = 10});

  Future<SearchVideosResponse> search({required String text, String? next});
}
