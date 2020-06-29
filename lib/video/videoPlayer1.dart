import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoplayer2 extends StatefulWidget {
  String Url;
videoplayer2({this.Url});
  @override
  videoplayer2State createState() => videoplayer2State();
}

class videoplayer2State extends State<videoplayer2> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId:widget.Url,
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
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )),

   //   height: double.infinity,
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
