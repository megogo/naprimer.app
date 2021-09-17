import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/profile/personal/personal_profile_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';

import '../profile_type.dart';
import '../widgets/profile_sliver_app_bar.dart';
import '../widgets/profile_sliver_persistent_header_delegate.dart';

class PersonalProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PersonalProfileController(),
      builder: (PersonalProfileController controller) {
        if (!controller.isAuth) {
          return Container();
        } else {
          return Material(
            child: DefaultTabController(
              length: ProfileTabType.values.length,
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
        tabs: ProfileTabType.values
            .map((tab) => Tab(
                  text: tab.label,
                ))
            .toList());
  }

  Widget _buildTabBarView(
      BuildContext context, PersonalProfileController controller) {
    return TabBarView(
        children: ProfileTabType.values
            .map((tabType) => ProfileTab(
                  tabType: tabType,
                  profileType: ProfileType.Personal,
                  userModel: controller.user,
                ))
            .toList());
  }
}
