import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:naprimer_app_v2/app/pages/for_you/for_you_controller.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';
import 'package:naprimer_app_v2/app/widgets/naprimer_app_bar.dart';
import 'package:naprimer_app_v2/app/widgets/skeleton_video/skeleton_video_tile_grid.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_grid.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';

class ForYouPage extends GetView<ForYouController> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<ForYouController>(
        builder: (ForYouController controller) {
          final List<String> initialInViewIds = [
            if (controller.videosList.length > 0) controller.videosList[0].id,
            if (controller.videosList.length > 1) controller.videosList[1].id,
          ];
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.extentAfter < 250) {
                controller.fetchMoreVideos();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: InViewNotifierCustomScrollView(
                isInViewPortCondition: isViewPortConditionCalculation,
                initialInViewIds: initialInViewIds,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _buildAppBar(),
                  controller.videosList.isEmpty
                      ? _buildPlaceholder()
                      : _buildBody(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isViewPortConditionCalculation(
      double deltaTop, double deltaBottom, double vpHeight) {
    if (controller.isPreviewPage) {
      int minDeltaTop = 70;
      int minViewportHeight = 370;
      if (vpHeight.toInt() < minViewportHeight) return false;
      if (deltaTop > 0 && deltaTop < minDeltaTop) return false;
    }
    return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  }

  Widget _buildAppBar() {
    return NaprimerAppBar.sliver(title: 'For You');
  }

  Widget _buildPlaceholder() {
    return SliverPadding(
      padding: EdgeInsets.only(top: defaultPadding),
      sliver: SkeletonVideoTileGrid.sliverGrid(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
          left: defaultPadding, top: defaultPadding, right: defaultPadding),
      sliver: _buildVideoGrid(MediaQuery.of(context).size.width,
          controller.isLoading, controller.videosList),
    );
  }

  Widget _buildVideoGrid(
      double maxWidth, bool isLoadingMore, List<VideoItem> itemList) {
    return VideoGrid.autoplaying(
        itemList: itemList,
        isLoadingMore: isLoadingMore,
        isUserAuth: controller.isUserAuth,
        onProfilePressed:controller.onProfilePressed,
    );
  }
}
