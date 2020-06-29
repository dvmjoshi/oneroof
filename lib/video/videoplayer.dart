import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

 class videoplayer extends StatefulWidget {

  @override
  videoplayerState createState() => videoplayerState();
}

class videoplayerState extends State<videoplayer> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=x0NB2KB2et4'),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    });

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
        child:YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
          },
        ),

    );
  }

  Widget loadingVideo() => Container(
    color: Colors.black,
    child: Center(
      child: GFLoader(
        type: GFLoaderType.circle,
        loaderColorOne: Colors.blueAccent,
        loaderColorTwo: Colors.black,
        loaderColorThree: Colors.pink,
      ),
    ),
  );
}
