import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IBVideo extends StatefulWidget {
  final Size size;
  final File video;

  IBVideo(this.size, this.video);

  @override
  State<StatefulWidget> createState() {
    return _IBVideoState(size, video);
  }
}

class _IBVideoState extends State<IBVideo> {
  _IBVideoState(this.size, this.video);
  final Size size;
  final File video;

  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.file(video);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      // Try playing around with some of these other options:

      // showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size.width,
      height: size.height,
      color: Colors.redAccent,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
