import 'package:chewie/chewie.dart';
import 'package:education_app/core/common/widgets/nested-back-button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({required this.videoURL, super.key});

  static const routeName = '/video-player';

  final String videoURL;
  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    await videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      hideControlsTimer: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const NestedBackButton(),
        backgroundColor: Colors.transparent,
      ),
       body: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
