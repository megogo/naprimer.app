import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';

class MenuItemWidget extends StatefulWidget {
  final String label;
  final GestureTapCallback? onTap;

  MenuItemWidget({
    required this.label,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _MenuItemWidgetState();
  }
}

class _MenuItemWidgetState extends State<MenuItemWidget>
    with TickerProviderStateMixin {
  final Duration _animDuration = const Duration(milliseconds: 100);
  late AnimationController _animController;
  late Tween _paddingTween;
  late Tween _colorTween;
  late CurvedAnimation _curvedAnim;
  late bool _isTapUp;
  late int _tapDownMillis;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: _animDuration, vsync: this);
    _isTapUp = false;
    _tapDownMillis = 0;
    _paddingTween = Tween<double>(begin: 16, end: 24);
    _colorTween =
        ColorTween(begin: AppColors.white, end: AppColors.greyTextDark);

    _curvedAnim =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              if (_isTapUp && widget.onTap != null) {
                // end of reverse animation
                widget.onTap!();
              }
              _isTapUp = false;
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    _animController.stop();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _tapUpIfAnimReady,
      onTapCancel: () {
        _animController.reverse();
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.darkButton),
        height: 50,
        child: AnimatedBuilder(
            animation: _animController,
            builder: (_, _a) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _paddingTween.evaluate(_curvedAnim)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: AppTextTheme.settingsMenuItemStyle
                          .apply(color: _colorTween.evaluate(_curvedAnim)),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: _colorTween.evaluate(_curvedAnim),
                      size: 16,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _tapUpIfAnimReady(TapUpDetails _) {
    final dMillis = DateTime.now().millisecondsSinceEpoch - _tapDownMillis;
    if (dMillis < _animDuration.inMilliseconds) {
      Timer(
        Duration(milliseconds: _animDuration.inMilliseconds - dMillis),
        _onTapUp,
      );
    } else {
      _onTapUp();
    }
  }

  void _onTapUp() {
    _isTapUp = true;
    _animController.reverse();
  }

  void _onTapDown(TapDownDetails _) {
    _tapDownMillis = DateTime.now().millisecondsSinceEpoch;
    _animController.forward();
  }
}
