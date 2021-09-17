import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_type.dart';
import 'package:naprimer_app_v2/app/pages/profile/widgets/profile_sliver_app_bar.dart';
import 'package:naprimer_app_v2/app/pages/profile/widgets/profile_sliver_persistent_header_delegate.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';

import 'general_profile_controller.dart';

class GeneralProfilePage extends GetView<GeneralProfileController> {
  const GeneralProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: controller.fetchUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              //todo need to discuss loader
              return Container(
                alignment: AlignmentDirectional.center,
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              print('-----------');
              print('${controller.user.name}');
              print('-----------');
              return Material(
                child: DefaultTabController(
                  length: controller.tabs.length,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverPersistentHeader(
                          delegate: ProfileSliverAppBar(
                            expandedHeight: 200,
                            avatar: controller.avatar,
                            bgColor: controller.backgroundColor,
                            ctaLabel: 'Settings',
                            onCtaPressed: controller.onSettingsPressed,
                          ),
                          pinned: true,
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: _buildUserName(controller.userName),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: ProfileSliverPersistentHeaderDelegate(
                              tabBar: _buildTabBar(),
                              backgroundColor: Colors.black),
                          pinned: true,
                        ),
                      ];
                    },
                    body: _buildTabBarView(context, controller),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  Widget _buildUserName(String userName) {
    return Padding(
      padding: const EdgeInsets.only(top: 52, bottom: 34),
      child: Text(
        userName,
        style: AppTextTheme.titleTextStyle,
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
        indicatorColor: AppColors.accentBlue,
        isScrollable: true,
        unselectedLabelStyle: AppTextTheme.unselectedTabBarLabelStyle,
        tabs: controller.tabs
            .map((tab) => Tab(
                  text: tab.label,
                ))
            .toList());
  }

  Widget _buildTabBarView(
      BuildContext context, GeneralProfileController controller) {
    return TabBarView(
        children: controller.tabs
            .map((tabType) => ProfileTab(
                  tabType: tabType,
                  profileType: ProfileType.General,
                  userModel: controller.user,
                ))
            .toList());
  }
}
