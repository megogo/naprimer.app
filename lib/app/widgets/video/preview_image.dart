import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderUrl;

  PreviewImage({
    required this.imageUrl,
    this.placeholderUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (c, obj) {
        return Image(image: obj,
          fit: BoxFit.fitHeight,
          height: MediaQuery.of(context).size.height,
          filterQuality: FilterQuality.medium,);
      },
      placeholder: (context, url) => Center(
        child: Icon(
          Icons.image,
          color: Colors.white24,
          size: 50,
        ),
      ),
      useOldImageOnUrlChange: true,
      errorWidget: (context, url, error) {
        return Center(
          child: Icon(
            Icons.image,
            color: Colors.white24,
            size: 50,
          ),
        );
      },
    );
  }
}
