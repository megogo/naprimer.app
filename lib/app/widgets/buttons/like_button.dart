import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

import 'button_wrapper.dart';

class LikeButton extends StatelessWidget {
  final String likesCountString;
  final bool isLiked;
  final GestureTapCallback? onTap;

  LikeButton({
    required this.likesCountString,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(41)),
            color: isLiked ? AppColors.white : AppColors.black.withOpacity(0.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                likesCountString,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isLiked ? AppColors.accentBlue : AppColors.white,
                ),
              ),
             const SizedBox(
                width: 4,
              ),
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: isLiked ? AppColors.accentBlue : AppColors.white,
              ),
            ],
          ),
        ),
      )
    );
  }
}
