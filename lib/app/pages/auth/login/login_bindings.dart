import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/app/pages/auth/login/login_controller.dart';
import 'package:naprimer_app_v2/data/auth/auth_repository.dart';
import 'package:naprimer_app_v2/services/networking/network_service.dart';

import '../../app_controller.dart';

class LoginBindings implements Bindings{

  @override
  void dependencies() {
    Get.put(AuthRepository(
        networkService: Get.find<NetworkService>(), authConfig: AuthConfig()));
    Get.put(LoginController());
    Get.put(AppController());
  }
}