import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/custom_icon_button.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';

import 'auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            _buildBackgroundEffect(),
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                    pinned: false,
                    delegate: SettingsDynamicHeader(
                        context: context, controller: controller)),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LargeButton(
                          onTap: controller.onSignUpPressed,
                          label: "Sign up",
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LargeButton(
                            label: 'Login',
                            type: LargeButtonType.greyTextOnly,
                            onTap: controller.onLoginPressed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundEffect() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          color: Colors.black87,
        ),
      ),
    );
  }
}

class SettingsDynamicHeader extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final AuthController controller;

  SettingsDynamicHeader({required this.context, required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButton(
                iconData: Icons.close, onTap: controller.onBackPressed),
            Expanded(
              child: Center(
                child: Text(
                  "Login or sign up to continue",
                  textAlign: TextAlign.center,
                  style:AppTextTheme.titleTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent {
    double height = MediaQuery.of(context).size.height;
    return height > 0 ? height / 2 : minExtent;
  }

  @override
  double get minExtent => 145.0;
}
