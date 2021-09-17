import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/styling/assets.dart';

class AppAvatarFactory {
  static Widget network(
      {required String avatarLink,
      BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
      Widget? progressWidget,
      Widget? errorWidget,
      Size size = const Size(32, 32)}) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: avatarLink,
          fit: BoxFit.fill,
          imageBuilder: (context, obj) {
            return Image(
              image: obj,
              width: size.width,
              height: size.height,
            );
          },
          progressIndicatorBuilder: (context, url, progress) {
            return progressWidget != null
                ? progressWidget
                : Icon(
                    Icons.image,
                    color: Colors.white10,
                    size: (size.width + size.height) / 2,
                  );
          },
          errorWidget: (context, url, error) {
            return errorWidget != null
                ? errorWidget
                : Center(
                    child: Icon(
                    Icons.image,
                    color: Colors.white10,
                    size: (size.width + size.height) / 2,
                  ));
          }),
    );
  }

  static Widget asset(
      {String avatarAssetLink = Assets.defaultAvatar,
      BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
      Widget? progressWidget,
      Widget? errorWidget,
      Size size = const Size(32, 32)}) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          avatarAssetLink,
          errorBuilder: (context, obj, stackTrace) {
            return errorWidget != null
                ? errorWidget
                : Center(
                    child: Icon(
                    Icons.image,
                    color: Colors.white10,
                    size: (size.width + size.height) / 2,
                  ));
          },
        ));
  }
}
