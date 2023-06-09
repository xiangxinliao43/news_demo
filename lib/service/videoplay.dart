import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoWidget1 extends StatefulWidget {

  final String playUrl;

  ChewieVideoWidget1(this.playUrl);
  @override
  _ChewieVideoWidget1State createState() => _ChewieVideoWidget1State();
}

class _ChewieVideoWidget1State extends State<ChewieVideoWidget1> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.playUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      //aspectRatio: 3 / 2.0,
      //customControls: CustomControls(),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(controller: _chewieController,),
    );
  }
}

