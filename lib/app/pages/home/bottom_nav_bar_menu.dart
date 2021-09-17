import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum BottomNavBarMenu { ForYou, Create, Search, Profile }

extension BottomNavBarMenuData on BottomNavBarMenu {
  String get label {
    switch (this) {
      case BottomNavBarMenu.ForYou:
        return 'For You';
      case BottomNavBarMenu.Create:
        return 'Create';
      case BottomNavBarMenu.Search:
        return 'Search';
      case BottomNavBarMenu.Profile:
        return 'Profile';
    }
  }

  IconData get activeIcon {
    switch (this) {
      case BottomNavBarMenu.ForYou:
        return Icons.home;
      case BottomNavBarMenu.Create:
        return Icons.add_circle_outline;
      case BottomNavBarMenu.Search:
        return Icons.search;
      case BottomNavBarMenu.Profile:
        return Icons.account_circle;
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavBarMenu.ForYou:
        return Icons.home_outlined;
      case BottomNavBarMenu.Create:
        return Icons.add_circle_outline;
      case BottomNavBarMenu.Search:
        return Icons.search;
      case BottomNavBarMenu.Profile:
        return Icons.account_circle;
    }
  }
}
