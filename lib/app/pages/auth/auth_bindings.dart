import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/auth/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
