import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/settings/settings_controller.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController(
      userController: Get.find<UserController>(),
    ));
  }
}
