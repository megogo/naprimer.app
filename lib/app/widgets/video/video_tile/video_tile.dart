import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/date_time_ext.dart';
import 'package:naprimer_app_v2/app/utils/int_ext.dart';
import 'package:naprimer_app_v2/app/widgets/avatar/circle_avatar.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/button_wrapper.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/like_button.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_tile/video_tile_controller.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_tile_preview.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';
import 'package:naprimer_app_v2/services/video/video_controller.dart';

class VideoTile extends StatelessWidget {
  final bool isInView;
  final VideoItem videoItem;
  final bool isUserAuth;
  final Function onProfilePressed;

  VideoTile({
    this.isInView = false,
    required this.videoItem,
    required this.isUserAuth,
    required this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: VideoTileController(
        item: videoItem,
        isUserAuth: isUserAuth,
        videoController: Get.find<VideoController>(),
      ),
      builder: (VideoTileController controller) {
        return ButtonWrapper(
          onTap: controller.onGoToVideoPressed,
          onDoubleTap: controller.onLikePressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildAvatarTitle(context, controller),
              const SizedBox(height: 12),
              buildBody(context, controller),
              const SizedBox(height: 12),
              buildViewsLabel(controller.item, controller),
            ],
          ),
        );
      },
    );
  }

  Widget buildAvatarTitle(
      BuildContext context, VideoTileController controller) {
    return ButtonWrapper(
      // onTap: () => controller.onProfilePressed(context),
      onTap: () => onProfilePressed(videoItem.authorId),
      child: Row(
        children: <Widget>[
          controller.avatarLink == null
              ? AppAvatarFactory.asset()
              : AppAvatarFactory.network(avatarLink: controller.avatarLink!),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(controller.authorName,
                maxLines: 2, style: AppTextTheme.profileNameSmallStyle),
          )
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, VideoTileController controller) {
    double width = (MediaQuery.of(context).size.width / 2);
    const height = 250.0;
    return Container(
      width: width,
      height: height,
      child: _buildBodyForVideoState(controller.videoState(), controller),
    );
  }

  Widget _buildBodyForVideoState(
      VideoState videoState, VideoTileController controller) {
    switch (videoState) {
      case VideoState.UPLOADING:
      case VideoState.PROCESSING:
        return _buildLoadingWidget(videoState);
      case VideoState.READY:
        return Stack(
          children: [
            TileVideoPreview(
              imagePreview: controller.imagePreview!,
              videoPreview: controller.videoPreview,
              isInView: isInView,
            ),
            GetBuilder<VideoTileController>(
                id: controller.likeBtnId,
                builder: (context) {
                  return Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: LikeButton(
                        likesCountString: controller.likes,
                        isLiked: controller.isLiked,
                        onTap: controller.onLikePressed),
                  );
                })
          ],
        );
    }
  }

  Widget _buildLoadingWidget(VideoState videoState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          backgroundColor: Colors.white.withOpacity(0.3),
          strokeWidth: 1.5,
        ),
        SizedBox(height: 8),
        Text(
          videoState.label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildViewsLabel(VideoItem item, VideoTileController controller) {
    String timeFromRelease = item.releasedAt?.getTimeFromPublish ?? '';
    String viewsCount = item.interactions?.viewsCount.roundCount ?? '0';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 16,
          child: Text(
            '$timeFromRelease  ∙  $viewsCount views',
            style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white70),
          ),
        ),
        Container(
          height: 16,
          child: Text(
            controller.videoTitle,
            style: TextStyle(
                fontSize: 14, height: 1.4, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
