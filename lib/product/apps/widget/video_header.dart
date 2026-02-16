import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HeroVideo extends StatefulWidget {
  final String videoPath;
  final double borderRadius;
  final bool autoPlay;
  final bool loop;

  const HeroVideo({
    super.key,
    required this.videoPath,
    this.borderRadius = 20,
    this.autoPlay = true,
    this.loop = true,
  });

  @override
  State<HeroVideo> createState() => _HeroVideoState();
}

class _HeroVideoState extends State<HeroVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        if (widget.autoPlay) _controller.play();
        _controller.setLooping(widget.loop);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
