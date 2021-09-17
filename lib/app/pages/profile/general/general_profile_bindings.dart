import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'general_profile_controller.dart';

class GeneralProfileBindings extends Bindings {
  final GeneralProfileArguments arguments;

  GeneralProfileBindings({required this.arguments});

  @override
  void dependencies() {
    Get.put(GeneralProfileController(arguments));
  }
}
