import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:naprimer_app_v2/app/config/video_tiles_config.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/widgets/skeleton_video/skeleton_video_tile.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_tile/video_tile.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';

class VideoGrid {
  //todo we can add more config like sliverConfig, defaultAutoplaying, etc.  But should we?
  static autoplaying(
          {required List<VideoItem> itemList,
          required bool isLoadingMore,
          required bool isUserAuth,
          required Function onProfilePressed}) =>
      _AutoplayingVideoGrid(
        itemList: itemList,
        isLoadingMore: isLoadingMore,
        isUserAuth: isUserAuth,
        onProfilePressed: onProfilePressed,
      );
}

class _AutoplayingVideoGrid extends StatelessWidget {
  const _AutoplayingVideoGrid({
    Key? key,
    required this.itemList,
    required this.isLoadingMore,
    required this.isUserAuth,
    required this.onProfilePressed,
  }) : super(key: key);
  final List<VideoItem> itemList;
  final bool isLoadingMore;
  final bool isUserAuth;
  final Function onProfilePressed;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final int childCount =
        isLoadingMore ? itemList.length + 2 : itemList.length;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: videoTilesGridHorizontalSpacing,
        mainAxisSpacing: videoTilesGridVerticalSpacing,
        crossAxisCount: videoTilesGridCellsCount,
        childAspectRatio: getVideoTilesGridChildAspectRatio(width),
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final isRenderSkeletonItem =
              isLoadingMore && index >= itemList.length;
          if (isRenderSkeletonItem) {
            return SkeletonVideoTile();
          } else {
            final item = itemList[index];
            //todo fix issue when preview works only on first video in the Row
            return InViewNotifierWidget(
              id: item.id,
              builder: (BuildContext context, bool isInView, Widget? child) {
                return VideoTile(
                  isInView: isInView,
                  isUserAuth: isUserAuth,
                  videoItem: item,
                  onProfilePressed: onProfilePressed,
                );
              },
            );
          }
        },
        childCount: childCount,
      ),
    );
  }

  bool isPersonalVideo(String videoAuthorId) {
    String? userId = Get.find<AppController>().user?.id;
    if (userId != null) {
      return userId == videoAuthorId;
    } else {
      return false;
    }
  }
}
