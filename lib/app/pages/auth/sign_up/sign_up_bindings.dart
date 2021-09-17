import 'package:get/instance_manager.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/app/pages/auth/sign_up/sign_up_controller.dart';
import 'package:naprimer_app_v2/data/auth/auth_repository.dart';
import 'package:naprimer_app_v2/services/networking/network_service.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository(
        networkService: Get.find<NetworkService>(), authConfig: AuthConfig()));
    Get.put(SignUpController());
  }
}
