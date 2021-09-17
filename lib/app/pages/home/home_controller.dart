import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/pages/create/create_page.dart';
import 'package:naprimer_app_v2/app/pages/for_you/for_you_root.dart';
import 'package:naprimer_app_v2/app/pages/home/bottom_nav_bar_menu.dart';
import 'package:naprimer_app_v2/app/pages/home/home_page_arguments.dart';
import 'package:naprimer_app_v2/app/pages/profile/personal/personal_profile_page.dart';
import 'package:naprimer_app_v2/app/pages/search/search_root.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';

class HomeController extends GetxController {
  final HomePageArguments? arguments;
  late List<Widget> _tabs;
  late AppController _appController;

  HomeController({this.arguments});

  List<Widget> get tabs => _tabs;
  late int _selectedIndex;

  int get selectedIndex => _selectedIndex;

  @override
  void onInit() {
    super.onInit();
    _appController = Get.find<AppController>();
    _tabs = [ForYouRoot(), CreatePage(), SearchRoot(), PersonalProfilePage()];
  }

  @override
  InternalFinalCallback<void> get onStart {
    _selectedIndex = arguments?.selectedTab?.index ?? 0;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      update();
    });
    return super.onStart;
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
      case 2:
        navigateToIndex(index);
        break;
      case 1:
      case 3:
        if (_appController.user == null) {
          if (_selectedIndex != BottomNavBarMenu.ForYou.index) {
            navigateToIndex(BottomNavBarMenu.ForYou.index);
          }
          Get.toNamed(Routes.AUTH);
        } else {
          navigateToIndex(index);
        }
        break;
    }
  }

  void navigateToIndex(int index) {
    _selectedIndex = index;
    update();
  }

  Future<bool> onBackPressed() async {
    //todo should be refactored
    if (selectedIndex == 0) {
      Get.nestedKey(ForYouPages.navigatorKeyId)!
          .currentState
          ?.popUntil((route) {
        var currentRoute = route.settings.name ?? 'no current route';
        if (currentRoute == Routes.GENERAL_PROFILE) {
          Get.back(id: ForYouPages.navigatorKeyId);
        }
        return true;
      });
    } else if (selectedIndex == 2) {
      Get.nestedKey(SearchPages.navigatorKeyId)!
          .currentState
          ?.popUntil((route) {
        var currentRoute = route.settings.name ?? 'no current route';
        if (currentRoute == Routes.GENERAL_PROFILE) {
          Get.back(id: SearchPages.navigatorKeyId);
        }
        return true;
      });
    } else {
      Get.key.currentState?.popUntil((route) {
        var currentRoute = route.settings.name ?? 'no current route';
        if (currentRoute == Routes.SIGN_UP) {
          Get.back();
        }
        return true;
      });
    }

    if (_selectedIndex == 1) {
      onItemTapped(0);
    }
    return false;
  }
}
