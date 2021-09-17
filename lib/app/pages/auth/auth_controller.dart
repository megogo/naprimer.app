import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';

class AuthController extends GetxController {

  void onSignUpPressed() {
    Get.toNamed(Routes.SIGN_UP);
  }

  void onBackPressed() async {
    Get.back();
  }

  void onLoginPressed() {
    Get.toNamed(Routes.LOGIN);
  }
}
