import 'dart:ui';

import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/assets.dart';
import 'package:naprimer_app_v2/data/user/user_repository.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/networking/network_service.dart';
import 'package:naprimer_app_v2/services/storage/db_service.dart';

class GeneralProfileArguments {
  final String userId;

  GeneralProfileArguments(this.userId);
}

class GeneralProfileController extends GetxController {
  final GeneralProfileArguments arguments;
  late AppController _appController;

  GeneralProfileController(this.arguments);

  late AbstractUser _user;

  AbstractUser get user => _user;

  bool get isAuth => _appController.user != null;

  final String _defaultAvatar = Assets.defaultAvatar;

  // not sure if this logic is correct
  String get userName => _user.nickname ?? _user.name;

  String get avatar => _user.avatar ?? _defaultAvatar;

  Color? get backgroundColor => AppColors.backgroundDefaultProfileColor;

  late bool _isLoading;

  bool get isLoading => _isLoading;

  final List<ProfileTabType> _tabs = const [
    ProfileTabType.Videos,
    ProfileTabType.Likes
  ];

  List<ProfileTabType> get tabs => _tabs;

  @override
  void onInit() {
    super.onInit();
    this._appController = Get.find<AppController>();
    _isLoading = false;
  }

  void onSettingsPressed() {
    Get.toNamed(Routes.SETTINGS);
  }

  Future<void> fetchUserData() async {
    UserRepository userRepository = UserRepository(
        Get.find<DbService>(), Get.find<NetworkService>(), UserConfig());
    _user = await userRepository.findUserById(arguments.userId);
  }
}
