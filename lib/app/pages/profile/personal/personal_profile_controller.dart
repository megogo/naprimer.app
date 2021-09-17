import 'dart:ui';

import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/assets.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';

class PersonalProfileController extends GetxController {
  late AppController _appController;

  AbstractUser get _user => _appController.user!;

  AbstractUser get user => _user;

  bool get isAuth => _appController.user != null;

  final String _defaultAvatar = Assets.defaultAvatar;

  // not sure if this logic is correct
  String get userName => _user.nickname ?? _user.name;

  String get avatar => _user.avatar ?? _defaultAvatar;

  // not sure where I should take from a bg color;
  Color? get backgroundColor => AppColors.backgroundDefaultProfileColor;

  @override
  void onInit() {
    this._appController = Get.find<AppController>();
    super.onInit();
  }

  void onSettingsPressed() {
    Get.toNamed(Routes.SETTINGS);
  }
}
