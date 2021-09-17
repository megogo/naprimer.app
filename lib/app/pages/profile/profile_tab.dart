import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:naprimer_app_v2/app/pages/profile/general/general_profile_tab_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_type.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';
import 'package:naprimer_app_v2/app/widgets/skeleton_video/skeleton_video_tile_grid.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_grid.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';

import 'personal/personal_profile_tab_controller.dart';
import 'widgets/no_videos_widget.dart';

class ProfileTab extends StatelessWidget {
  final ProfileTabType tabType;
  final ProfileType profileType;
  final AbstractUser userModel;

  const ProfileTab(
      {Key? key,
      required this.tabType,
      required this.profileType,
      required this.userModel})
      : super(key: key);

  GetxController initProfileTabController() {
    return (profileType == ProfileType.General
        ? GeneralProfileTabController(tabType, userModel: userModel)
        : PersonalProfileTabController(tabType));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        global: false,
        init: initProfileTabController(),
        builder: (dynamic controller) {
          final List<String> initialInViewIds = [
            if (controller.videosList.length > 0) controller.videosList[0].id,
            if (controller.videosList.length > 1) controller.videosList[1].id,
          ];
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (tabType == ProfileTabType.Videos) {
                if (notification.metrics.extentAfter < 250) {
                  controller.fetchMoreVideos();
                }
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: InViewNotifierCustomScrollView(
                isInViewPortCondition: (deltaTop, deltaBottom, vpHeight) =>
                    isViewPortConditionCalculation(
                        true, deltaTop, deltaBottom, vpHeight),
                initialInViewIds: initialInViewIds,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverVisibility(
                      visible:
                          controller.videosList.isEmpty && controller.isLoading,
                      sliver: SkeletonVideoTileGrid.sliverGrid()),
                  controller.videosList.isEmpty
                      ? NoVideosWidget(profileTabType: controller.tabType)
                      : _buildBody(context, controller),
                ],
              ),
            ),
          );
        });
  }

  bool isViewPortConditionCalculation(bool isPreviewPage, double deltaTop,
      double deltaBottom, double vpHeight) {
    if (isPreviewPage) {
      int minDeltaTop = 70;
      int minViewportHeight = 370;
      if (vpHeight.toInt() < minViewportHeight) return false;
      if (deltaTop > 0 && deltaTop < minDeltaTop) return false;
    }
    return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  }

  Widget _buildBody(BuildContext context, ProfileTabController controller) {
    return SliverPadding(
      padding: const EdgeInsets.only(
          left: defaultPadding, top: defaultPadding, right: defaultPadding),
      sliver: VideoGrid.autoplaying(
          itemList: controller.videosList,
          isLoadingMore: controller.isLoading,
          isUserAuth: true,
          onProfilePressed: controller.onProfilePressed,

      ),
    );
  }
}
