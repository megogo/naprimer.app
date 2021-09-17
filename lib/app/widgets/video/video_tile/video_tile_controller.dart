import 'dart:async';

import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/app/utils/int_ext.dart';
import 'package:naprimer_app_v2/app/utils/string_ext.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/services/video/video_controller.dart';

enum VideoState { UPLOADING, PROCESSING, READY }

extension VideoStateData on VideoState {
  String get label {
    switch (this) {
      case VideoState.UPLOADING:
        return 'Uploading';
      case VideoState.PROCESSING:
        return 'Processing';
      case VideoState.READY:
        return 'Ready';
    }
  }
}

class VideoTileController extends GetxController {
  final VideoItem item;
  final VideoController videoController;
  final bool isUserAuth;
  late bool isLikeEnabled;

  VideoTileController({
    required this.item,
    required this.videoController,
    required this.isUserAuth,
  });

  String? get avatarLink => item.authorAvatar;

  String get authorName => item.authorName.truncate(40);

  String get videoTitle => item.title;

  String? get imagePreview => item.imagePreview;

  String get videoPreview => item.stream;

  String get likes => item.interactions?.likesCount.roundCount ?? '0';

  bool get isLiked => videoController.isVideoLiked(item.id);

  final String likeBtnId = 'likeBtnId';

  @override
  void onInit() {
    super.onInit();
    isLikeEnabled = true;
  }

  //todo mb should be passed here
  Future<void>? onLikePressed() async {
    if (!isLikeEnabled) return null;

    if (Get.find<AppController>().user != null) {
      isLikeEnabled = false;
      update([likeBtnId]);

      await toggleLike();

      isLikeEnabled = true;
      update([likeBtnId]);
    } else {
      Get.toNamed(Routes.AUTH);
    }
  }

  Future<void> toggleLike() async {
    item.interactions?.likesCount += !isLiked ? 1 : -1;
    await videoController.toggleLikeVideo(video: item, isLiked: !isLiked);
  }

  VideoState videoState() {
    return VideoState.READY;
    //todo not ready to be implemented
    // return VideoState.PROCESSING;
    // return VideoState.UPLOADING;
    // // if (videoItem.isDraft) {
    // //   MyUserModel userModel = Modular.get<MyUserModel>();
    // //   return userModel.videoIsUploading(videoItem.id)
    // //       ? _VideoState.processing
    // //       : _VideoState.uploading;
    // // } else {
    // //   return _VideoState.ready;
    // // }
  }

  void onGoToVideoPressed() {
    return null;
    // String path = '${Constants.ROUTE_VIDEO}/${widget.item.id}';
    //
    // Modular.to.path != Constants.ROUTE_VIDEO
    //     ? Modular.to.pushNamed(path)
    //     : Modular.to.popAndPushNamed(path);
  }
}
