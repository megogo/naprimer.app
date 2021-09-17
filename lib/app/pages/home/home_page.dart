import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/home/bottom_nav_bar_menu.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(builder: (controller) {
        return WillPopScope(
          onWillPop: controller.onBackPressed,
          child: SafeArea(
            child: Scaffold(
              body: IndexedStack(
                  index: controller.selectedIndex, children: controller.tabs),
              bottomNavigationBar: _buildBottomNavigationBar(controller),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomNavigationBar(HomeController controller) {
    return Visibility(
      visible: controller.selectedIndex != BottomNavBarMenu.Create.index,
      child: BottomNavigationBar(
        items: _buildItems(),
        currentIndex: controller.selectedIndex,
        onTap: (index) => controller.onItemTapped(index),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildItems() {
    return BottomNavBarMenu.values
        .map((item) => BottomNavigationBarItem(
              activeIcon: Icon(item.activeIcon),
              icon: Icon(item.icon),
              label: item.label,
            ))
        .toList();
  }
}
