import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.videoPath, required this.onDelete});
  final String videoPath;
  final Function() onDelete;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  ChewieController? _chewieController;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: false,
          looping: true,
          zoomAndPan: true,
          autoInitialize: true,

          aspectRatio: _controller.value.aspectRatio,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController == null
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Chewie(controller: _chewieController!),
                  ),
                ),
              ),

              Positioned(
                left: 5,
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: widget.onDelete,
                  ),
                ),
              ),
            ],
          );
  }
}
