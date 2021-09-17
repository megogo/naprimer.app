import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/home/bottom_nav_bar_menu.dart';
import 'package:naprimer_app_v2/app/pages/home/home_page_arguments.dart';
import 'package:naprimer_app_v2/app/pages/settings/edit/settings_edit_controller.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';

import 'field_type.dart';

class SettingsController extends GetxController {
  final UserController userController;

  SettingsController({required this.userController});

  RxString get name => userController.user.value!.name.obs;

  RxString? get username => userController.user.value?.name.obs;

  void onItemPressed(FieldType fieldType) {
    Get.toNamed(Routes.SETTINGS_EDIT,
        arguments: SettingsEditArguments(fieldType: fieldType));
  }

  void onLogOutPressed() async {
    await userController.logout();
    Get.offNamedUntil(Routes.HOME, (Route<dynamic> route) => false,
        arguments: HomePageArguments(selectedTab: BottomNavBarMenu.ForYou));
  }
}
