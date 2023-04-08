import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerItem extends StatelessWidget {
  const TrailerItem({super.key, required this.trailerkey});

  final String trailerkey;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: trailerkey,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      aspectRatio: 16 / 9,
      showVideoProgressIndicator: true,
    );
  }
}
