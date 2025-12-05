import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    super.key,
    required this.videoController,
    required this.onDelete,
  });
  final VideoPlayerController videoController;
  final Function() onDelete;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
/*   ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    widget.videoController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: widget.videoController,
          autoPlay: false,
          looping: false,
          zoomAndPan: true,
          autoInitialize: true,
          aspectRatio: widget.videoController.value.aspectRatio,
        );
      });
      setState(() {});
    });
  } */

/*   @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 450,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: VideoPlayer(widget.videoController),
                  ),
                ),
              ),
              if (widget.videoController.value.isPlaying)
                const Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
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
