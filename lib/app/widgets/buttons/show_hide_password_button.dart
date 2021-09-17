import 'package:flutter/material.dart';

import 'button_wrapper.dart';

class ShowHidePasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isVisible;

  ShowHidePasswordButton({
    required this.onTap,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      child: Container(
        width: 30,
        color: Colors.transparent,
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          isVisible ? "HIDE" : "SHOW",
          style: TextStyle(
            color: Color.fromARGB(120, 255, 255, 255),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
