import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class PreviewVideo extends StatefulWidget {
  final String url;

  PreviewVideo(this.url);

  @override
  State<StatefulWidget> createState() => PreviewVideoState();
}

class PreviewVideoState extends State<PreviewVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.initialize().then((_) {
        setState(() {
          _controller.setVolume(0.0);
          _controller.play();
          _controller.setLooping(true);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Container();
    //todo should be checked but seems like it stretches the video
    // return _controller.value.isInitialized
    //       ? SizedBox.expand(
    //     child: FittedBox(
    //       fit: BoxFit.cover,
    //       child: SizedBox(
    //         width: _controller.value.size.width ,
    //         height: _controller.value.size.height,
    //         child: VideoPlayer(_controller),
    //       ),
    //     ),
    //   )
    //       : Container();
  }
}
