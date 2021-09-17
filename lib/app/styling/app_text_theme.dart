import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

class AppTextTheme {
  AppTextTheme._internal();

  static final _instance = AppTextTheme._internal();

  factory AppTextTheme() => _instance;

  static final TextTheme defaultAppTheme = TextTheme(

      //todo titles and body text styles should be defined here
      );

  static const TextStyle titleTextStyle = TextStyle(
      color: AppColors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.4);

  static const TextStyle titleTextStyle2 =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static const TextStyle settingsPropsStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  static const TextStyle errorMessageStyle = TextStyle(
      color: Colors.red,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      height: 1.4);

  static const TextStyle profileTabDescriptionStyle =
      TextStyle(color: Colors.white70, fontSize: 14);

  static const TextStyle unselectedTabBarLabelStyle =
      TextStyle(color: Colors.white70, fontSize: 14);

  static const TextStyle settingsMenuItemStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static const TextStyle appBarStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  static const TextStyle profileNameSmallStyle = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(
      color: AppColors.lightGrey, fontSize: 14, fontWeight: FontWeight.w600);
}
