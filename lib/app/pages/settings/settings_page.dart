import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/settings/settings_controller.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';

import 'field_type.dart';
import 'menu/menu.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(delegate: SettingsDynamicHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Menu(
                  header: 'Profile',
                  menuItems: [
                    MenuItemModel(
                        title: 'Name',
                        value: controller.name,
                        onTap: () => controller.onItemPressed(FieldType.Name),
                        fieldType: FieldType.Name),
                    MenuItemModel(
                        title: 'Username',
                        value: controller.username ?? '',
                        onTap: () =>
                            controller.onItemPressed(FieldType.Username),
                        fieldType: FieldType.Username),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: LargeButton(
                  label: 'Log out',
                  type: LargeButtonType.dark,
                  onTap: controller.onLogOutPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDynamicHeader extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 145.0;
  final double _minExtent = 145.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          IconButton(
            padding: EdgeInsets.only(left: 24),
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 16),
            child: Text("Settings", style: AppTextTheme.titleTextStyle),
          )
        ],
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => false;

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;
}
