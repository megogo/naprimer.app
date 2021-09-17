import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:naprimer_app_v2/app/pages/search/search_controller.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/button_wrapper.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';
import 'package:naprimer_app_v2/app/widgets/naprimer_app_bar.dart';
import 'package:naprimer_app_v2/app/widgets/skeleton_video/skeleton_video_tile_grid.dart';
import 'package:naprimer_app_v2/app/widgets/text/styled_text_field.dart';
import 'package:naprimer_app_v2/app/widgets/video/video_grid.dart';
import 'package:naprimer_app_v2/data/video/video_item.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          final List<String> initialInViewIds = [
            if (controller.videosList.length > 0) controller.videosList[0].id,
            if (controller.videosList.length > 1) controller.videosList[1].id,
          ];
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.extentAfter < 250) {
                controller.searchMore();
              }
              return true;
            },
            child: InViewNotifierCustomScrollView(
              isInViewPortCondition: (dTop, dBottom, vpHeight) =>
                  isViewPortConditionCalculation(
                      dTop, dBottom, vpHeight, controller),
              initialInViewIds: initialInViewIds,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildAppBar(controller),
                _buildSearchBar(controller),
                _buildBody(controller: controller, context: context)
              ],
            ),
          );
        },
      ),
    );
  }

  bool isViewPortConditionCalculation(double deltaTop, double deltaBottom,
      double vpHeight, SearchController controller) {
    int minDeltaTop = 70;
    int minViewportHeight = 370;
    if (vpHeight.toInt() < minViewportHeight) return false;
    if (deltaTop > 0 && deltaTop < minDeltaTop) return false;
    return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  }

  Widget _buildAppBar(SearchController controller) {
    return NaprimerAppBar.sliver(title: 'Search');
  }

  Widget _buildSearchBar(SearchController controller) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: _PersistentHeader(
          widget: Row(children: [
            Expanded(
              child: StyledTextField.filled(
                focusNode: controller.searchFocusNode,
                textInputAction: TextInputAction.search,
                controller: controller.searchTextController,
                hintText: 'Search',
                prefixIcon: Icons.search,
                suffixIcon: Visibility(
                  visible: controller.isShowClearButton,
                  child: ButtonWrapper(
                    onTap: controller.onClearPressed,
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Colors.white30,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.isShowCancelButton,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: LargeButton(
                    type: LargeButtonType.greyTextOnly,
                    label: 'Cancel',
                    onTap: controller.onCancelPressed),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildBody(
      {required SearchController controller, required BuildContext context}) {
    switch (controller.stateOfView) {
      case SearchState.INITIAL:
        return _buildInitial();
      case SearchState.LOADING:
        return _buildPlaceholder();
      case SearchState.NOTHING_FOUND:
        return _buildNothingFound();
      case SearchState.FOUND:
        return _buildVideoGrid(
            controller: controller,
            maxWidth: MediaQuery.of(context).size.width,
            isLoadingMore: controller.isLoading,
            itemList: controller.videosList);
    }
  }

  Widget _buildPlaceholder() {
    return SliverFillRemaining(
      child: Stack(
        children: [
          SkeletonVideoTileGrid.defaultGrid(padding: EdgeInsets.only(top: 16)),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.lightGrey, shape: BoxShape.circle),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(8.0),
              height: 48,
              width: 48,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInitial() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          'Type your search request',
          textAlign: TextAlign.center,
          style: AppTextTheme.caption,
        ),
      ),
    );
  }

  Widget _buildNothingFound() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('No Result', style: AppTextTheme.titleTextStyle2),
          const SizedBox(height: 6),
          const Text(
            'Try different request',
            textAlign: TextAlign.center,
            style: AppTextTheme.caption,
          )
        ],
      ),
    );
  }

  //todo probably should be refactored and used in feed and here
  Widget _buildVideoGrid(
      {required SearchController controller,
      required double maxWidth,
      required bool isLoadingMore,
      List<VideoItem> itemList = const []}) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        sliver: VideoGrid.autoplaying(
            itemList: controller.videosList,
            isLoadingMore: isLoadingMore,
            isUserAuth: controller.isUserAuth,
            onProfilePressed: controller.onProfilePressed));
  }
}

class _PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  _PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      margin: EdgeInsets.only(bottom: 8.0),
      color: Colors.black,
      child: Center(child: widget),
    );
  }

  @override
  double get maxExtent => 64.0;

  @override
  double get minExtent => 64.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
