import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

import 'button_wrapper.dart';

enum RoundedButtonHeightType { medium, small }
enum RoundedButtonColorType { white, grey, blue, lightGrey}

class RoundedButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final RoundedButtonHeightType heightType;
  final RoundedButtonColorType colorType;

  final bool isBlocked;

  RoundedButton({
    this.label = '',
    required this.onTap,
    this.heightType = RoundedButtonHeightType.medium,
    this.colorType = RoundedButtonColorType.white,
    this.isBlocked = false
  });

  EdgeInsets _getPadding() {
    EdgeInsets result;
    switch (heightType) {
      case RoundedButtonHeightType.medium:
        result = const EdgeInsets.symmetric(horizontal: 20, vertical: 13);
        break;
      case RoundedButtonHeightType.small:
        result = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        break;
    }
    return result;
  }

  Color _getFillColor() {
    Color result;
    switch (colorType) {
      case RoundedButtonColorType.blue:
      case RoundedButtonColorType.white:
        result = AppColors.white;
        break;
      case RoundedButtonColorType.grey:
        result = AppColors.darkGrey;
        break;
      case RoundedButtonColorType.lightGrey:
        result = AppColors.lightGrey;
        break;
    }
    return result;
  }

  Color _getTextColor() {
    Color result;
    switch (colorType) {
      case RoundedButtonColorType.white:
        result = AppColors.black;
        break;
      case RoundedButtonColorType.blue:
        result = AppColors.accentBlue;
        break;
      case RoundedButtonColorType.lightGrey:
      case RoundedButtonColorType.grey:
        result = AppColors.white;
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      isBlocked: isBlocked,
      child: FittedBox(
        child: Container(
          padding: _getPadding(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(44)),
            color: _getFillColor(),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
