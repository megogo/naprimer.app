import 'package:flutter/material.dart';

import 'button_wrapper.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final double iconSize;
  final VoidCallback onTap;

  CustomIconButton(
      {required this.iconData,
      this.iconColor,
      required this.onTap,
      this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        child: Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
