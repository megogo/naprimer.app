import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/widgets/video/preview_image.dart';
import 'package:naprimer_app_v2/app/widgets/video/preview_video.dart';

import 'fade_widget.dart';

class TileVideoPreview extends StatefulWidget {
  final String videoPreview;
  final String imagePreview;
  final bool isInView;

  TileVideoPreview(
      {Key? key,
      required this.videoPreview,
      required this.imagePreview,
      this.isInView = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TileVideoPreviewState();
  }
}

class TileVideoPreviewState extends State<TileVideoPreview> {
  bool _isShowAnimatedPreview = false;
  Timer? _startTimer;

  @override
  void initState() {
    super.initState();
    _resolveIsInView();
  }

  @override
  void didUpdateWidget(covariant TileVideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isInView != oldWidget.isInView) {
      _resolveIsInView();
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeWidget(
      child: _isShowAnimatedPreview
          ? PreviewVideo(widget.videoPreview)
          : PreviewImage(
              imageUrl: widget.imagePreview,
              placeholderUrl: widget.imagePreview,
            ),
      direction: AnimationDirection.forward,
      duration: Duration(milliseconds: 600),
    );
  }

  void _resolveIsInView() {
    if (widget.isInView) {
      _cancelTimer();
      _startTimer = Timer(Duration(seconds: 2), _onTimer);
    } else {
      _cancelTimer();
      _isShowAnimatedPreview = false;
    }
  }

  void _onTimer() {
    setState(() {
      _isShowAnimatedPreview = true;
    });
  }

  void _cancelTimer() {
    if (_startTimer != null) {
      _startTimer!.cancel();
      _startTimer = null;
    }
  }
}
