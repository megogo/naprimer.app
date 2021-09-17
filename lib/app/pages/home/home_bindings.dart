import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/for_you/for_you_controller.dart';
import 'package:naprimer_app_v2/app/pages/home/home_controller.dart';

class HomeBindings extends Bindings {
  final dynamic arguments;

  HomeBindings({this.arguments});

  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(arguments: arguments));
    Get.put<ForYouController>(ForYouController(), permanent: true);
  }
}
