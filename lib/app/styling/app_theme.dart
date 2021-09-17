import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';

class AppTheme {
  AppTheme._internal();

  static final _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  static final ThemeData defaultAppTheme = ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      bottomAppBarColor: Colors.black,
      accentColor: Colors.white,
      brightness: Brightness.dark,
      canvasColor: Colors.black,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.accentBlue,
          selectionColor: AppColors.accentBlue.withOpacity(0.5)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: AppTextTheme.defaultAppTheme);
}
