import 'package:flutter/material.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({required this.videoURL, super.key});

  static const routeName = '/video-player';

  final String videoURL;
  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
