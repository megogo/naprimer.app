import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/data/video/fetch_videos_response.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/video/video_controller.dart';

class GeneralProfileTabController extends GetxController
    implements ProfileTabController {
  final ProfileTabType tabType;
  final AbstractUser userModel;
  late VideoController _videoController;
  late List<VideoItem> _videosList;

  GeneralProfileTabController(this.tabType, {required this.userModel});

  List<VideoItem> get videosList => _videosList;

  late bool _isLoading;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    _videoController = Get.find<VideoController>();
    _videosList = [];
    _isLoading = false;
    super.onInit();
  }

  @override
  void onReady() async {
    await initialFetch();
    super.onReady();
  }

  Future<void> initialFetch() async {
    _startLoading();
    switch (tabType) {
      case ProfileTabType.Videos:
        await fetchVideos();
        break;
      case ProfileTabType.Likes:
        await fetchLikedVideos();
        break;
      case ProfileTabType.Unpublished:
        break;
    }
    _stopLoading();
    update();
  }

  Future<void> fetchVideos() async {
    FetchVideosResponse response = await _videoController.fetchUserVideos(
        userId: userModel.id, next: _videosList.length.toString());

    _videosList.addAll(response.videos);
  }

  //todo add to a profile page
  Future<void> fetchLikedVideos() async {
    List<VideoItem> list = await _videoController.fetchUserLikedVideos(
        userId: userModel.id, next: _videosList.length.toString(), limit: 2);
    _videosList.addAll(list);
  }

  Future<void> fetchMoreVideos() async {
    _startLoading();
    FetchVideosResponse response = await _videoController.fetchVideos(
        nextIndex: _videosList.length, itemCnt: 2);

    _videosList.addAll(response.videos);

    _stopLoading();
  }

  Future<void> onRefresh() async {
    _startLoading();
    late FetchVideosResponse response;
    //todo add try catch - needs to discuss what to show
    switch (tabType) {
      case ProfileTabType.Videos:
        response = await _videoController.fetchVideos(
            nextIndex: _videosList.length, itemCnt: 2);
        break;
      case ProfileTabType.Likes:
        response = await _videoController.fetchVideos(
            nextIndex: _videosList.length, itemCnt: 2);
        break;
      case ProfileTabType.Unpublished:
        break;
    }
    _videosList.clear();
    _videosList = response.videos;

    _stopLoading();
  }

  void _startLoading({List<Object>? ids}) {
    _isLoading = true;
    update(ids);
  }

  void _stopLoading({List<Object>? ids}) {
    _isLoading = false;
    update(ids);
  }

  @override
  void onProfilePressed(String authorId) {
    // TODO: implement onProfilePressed
  }

}
