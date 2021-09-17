import 'dart:async';

import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/data/user/user_repository.dart';
import 'package:naprimer_app_v2/data/video/video_repository.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/networking/network_client.dart';
import 'package:naprimer_app_v2/services/networking/network_service.dart';
import 'package:naprimer_app_v2/services/storage/db_client.dart';
import 'package:naprimer_app_v2/services/storage/db_service.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';
import 'package:naprimer_app_v2/services/video/video_controller.dart';

class AppController extends GetxController {
  late bool isInited;
  late bool isTimerIsOut;
  final int splashScreenShownDuration = 1;

  late UserController _userController;
  late VideoController _videoController;

  AbstractUser? user;

  VideoController get videoController => _videoController;

  @override
  void onInit() {
    isInited = false;
    isTimerIsOut = false;
    Timer(Duration(seconds: splashScreenShownDuration), () {
      isTimerIsOut = true;
      navigateNextIfReady();
    });

    super.onInit();
  }

  @override
  void onReady() async {
    await initServices();
    user = _userController.user.value;
    initialFetchForVideoController();
    addUserAuthListener();
    navigateNextIfReady();
    super.onReady();
  }

  void initialFetchForVideoController() {
    if (user != null) {
      _videoController.fetchLikedVideos(userId: user!.id);
    }
  }

  void addUserAuthListener() {
    _userController.user.listen((user) {
      this.user = user;
      if (user == null) {
        _videoController.clearFetchedVideos();
      } else {
        _videoController.fetchLikedVideos(
            userId: this.user!.id);
      }
    });
  }

  Future<void> initServices() async {
    //todo add logger
    await Get.putAsync(() => initNetworkService(), permanent: true);
    await Get.putAsync(() => initDbService(), permanent: true);
    await Get.putAsync(() => initUserController(), permanent: true);
    await _userController.loadUser();
    initVideoController();
    isInited = true;
  }

  Future<NetworkService> initNetworkService() async {
    return await Get.putAsync(
        () => NetworkService(NetworkClient())
            .init(config: NetworkServiceConfig()),
        permanent: true);
  }

  Future<DbService> initDbService() async {
    DbClient dbClient = DbClient();
    return DbService(client: await dbClient.init());
  }

  Future<UserController> initUserController() async {
    _userController = UserController(UserRepository(
        Get.find<DbService>(), Get.find<NetworkService>(), UserConfig()));
    return _userController;
  }

  void initVideoController() {
    Get.put<VideoRepository>(VideoRepository(
        networkService: Get.find<NetworkService>(), config: VideoConfig()));
    _videoController =
        Get.put<VideoController>(VideoController(), permanent: true);
  }

  void navigateNextIfReady() {
    if (isInited && isTimerIsOut) {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
