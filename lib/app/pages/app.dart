import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/app_controller.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/app/styling/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Naprimer App v2',
      theme: AppTheme.defaultAppTheme,
      initialRoute: GlobalPages.INITIAL,
      initialBinding: _buildBindings(),
      onGenerateRoute: GlobalPages.onGenerateRoute,
    );
  }
}

Bindings? _buildBindings() => BindingsBuilder(() {
      Get.put(AppController(), permanent: true);
    });
