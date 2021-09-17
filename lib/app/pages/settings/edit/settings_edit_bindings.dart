import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/settings/edit/settings_edit_controller.dart';

class SettingsEditBindings extends Bindings {
  final SettingsEditArguments arguments;

  SettingsEditBindings({required this.arguments});

  @override
  void dependencies() {
    Get.put(SettingsEditController(settingsEditArguments: arguments));
  }
}
