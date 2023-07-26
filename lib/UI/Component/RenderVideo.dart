import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class RenderVideo extends StatefulWidget {
  final String url;
  const RenderVideo({super.key, required this.url});

  @override
  State<RenderVideo> createState() => _RenderVideoState();
}

class _RenderVideoState extends State<RenderVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url!)!,
      flags: YoutubePlayerFlags(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YoutubePlayer(
            controller: _controller,
          showVideoProgressIndicator: true,
        )
      ],
    );
  }
}
