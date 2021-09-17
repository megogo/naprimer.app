import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

import 'button_wrapper.dart';

enum LargeButtonType {
  blue,
  dark,
  semiTransparent,
  redTextOnly,
  greyTextOnly,
}

class LargeButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final bool isLoading;
  final bool isBlocked;
  final LargeButtonType type;
  final String? leftIconSvgPath;

  LargeButton({
    this.label = '',
    this.isLoading = false,
    this.isBlocked = false,
    required this.onTap,
    this.type = LargeButtonType.blue,
     this.leftIconSvgPath,
  });

  Color? _getFillColor() {
    Color? result;
    if (isBlocked) {
      switch (type) {
        case LargeButtonType.blue:
        case LargeButtonType.dark:
        case LargeButtonType.semiTransparent:
          result = AppColors.darkButton;
          break;
        case LargeButtonType.greyTextOnly:
        case LargeButtonType.redTextOnly:
          result = null;
          break;
      }
    } else {
      switch (type) {
        case LargeButtonType.blue:
          result = AppColors.accentBlue;
          break;
        case LargeButtonType.dark:
          result = AppColors.darkButton;
          break;
        case LargeButtonType.semiTransparent:
          result = AppColors.white.withOpacity(0.1);
          break;
        case LargeButtonType.greyTextOnly:
        case LargeButtonType.redTextOnly:
          result = null;
          break;
      }
    }
    return result;
  }

  Color _getTextColor() {
    Color result;
    if (isBlocked) {
      result = AppColors.greyTextDark;
    } else {
      switch (type) {
        case LargeButtonType.blue:
        case LargeButtonType.dark:
        case LargeButtonType.semiTransparent:
          result = AppColors.white;
          break;
        case LargeButtonType.greyTextOnly:
          result = AppColors.greyText;
          break;
        case LargeButtonType.redTextOnly:
          result = AppColors.red;
          break;
      }
    }
    return result;
  }

  Widget _getLoadingLayout() {
    Widget result;
    switch (type) {
      case LargeButtonType.blue:
      case LargeButtonType.dark:
      case LargeButtonType.semiTransparent:
        result = Transform.scale(
          scale: 0.8,
          child: CircularProgressIndicator(),
        );
        break;
      case LargeButtonType.greyTextOnly:
      case LargeButtonType.redTextOnly:
        result = Container(
          margin: EdgeInsets.only(right: 36),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 0.35,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      isBlocked: isBlocked,
      onTap: isLoading ? null : onTap,
      child: Opacity(
        opacity: isBlocked ? 0.75 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: _getFillColor(),
          ),
          child: Stack(
            children: [
              Center(
                child: isLoading
                    ? _getLoadingLayout()
                    : Text(
                  label,
                  style: TextStyle(
                    color: _getTextColor(),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //todo add a bit later
              // if (leftIconSvgPath != null)
              //   Container(
              //     alignment: Alignment.centerLeft,
              //     margin: EdgeInsets.only(left: 16),
              //     child: WebsafeSvg.asset(
              //       leftIconSvgPath,
              //       height: 25,
              //       width: 25,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
