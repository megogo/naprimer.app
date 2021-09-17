import 'package:naprimer_app_v2/data/video/video_item.dart';

import 'profile_tab_type.dart';

abstract class ProfileTabController {
  final ProfileTabType tabType;
  late List<VideoItem> _videosList;

  ProfileTabController(this.tabType);

  List<VideoItem> get videosList => _videosList;

  late bool _isLoading;

  bool get isLoading => _isLoading;

  Future<void> initialFetch();

  Future<void> fetchVideos();

  Future<void> fetchMoreVideos();

  Future<void> onRefresh();

  void onProfilePressed(String authorId);
}
