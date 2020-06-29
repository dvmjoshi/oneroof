import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneroof/video/videoPlayer1.dart';

import 'delayed_animation.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();

    startTimer();
  }
  void startTimer() {
    Timer(Duration(seconds:7), () async {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }
  ScrollController _scrollController = ScrollController();

  _scrollToBottom(){  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
          body: Stack(
            children: [
              ListView(
                controller:  _scrollController,
                reverse: true,
                shrinkWrap: true,
addAutomaticKeepAlives: true,
                children: [
                  Image.asset("assets/earth1.gif",
                  fit: BoxFit.contain,),
                  Image.asset("assets/earth2.gif",   fit: BoxFit.contain),
                  Image.asset("assets/earth3.gif",
                      fit: BoxFit.contain),

                ],
              ),

            //   ukPlayer(url:"assets/home.mp4",),

              Center(
                child: Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 90,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.black12,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child:
                      Image.asset("assets/j1.png",height: 100,)
//                      Material(
//                          elevation: 8.0,
//                          shape: CircleBorder(),
//                          child: CircleAvatar(
//                            backgroundColor: Colors.transparent,
//                            child: Image.asset("assets/j1.png"),
//                            radius: 50.0,
//                          )),
                    ),
                    SizedBox(height: 55,),
                    DelayedAnimation(
                      child: Text(
                            "One Roof",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: color),
                      ),
                      delay: delayedAmount + 1000,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DelayedAnimation(
                        child: Text(
                              "The Earth is what we all have in common.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              color: color),
                        ),
                        delay: delayedAmount + 2000,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    DelayedAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Learn About Mother Earth and share life lesson",

                          style: TextStyle(fontSize: 20.0, color: color),
                        ),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    SizedBox(
                      height: 150.0,
                    ),
//                    DelayedAnimation(
//                      child: GestureDetector(
//                        onTapDown: _onTapDown,
//                        onTapUp: _onTapUp,
//                        child: Transform.scale(
//                          scale: _scale,
//                          child: _animatedButtonUI,
//                        ),
//                      ),
//                      delay: delayedAmount + 4000,
//                    ),
                    SizedBox(height: 80.0,),
                    DelayedAnimation(
                      child: Text(
                        "Explore with us".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      delay: delayedAmount + 4200,
                    ),
                  ],
                ),
              ),
            ],
          )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
      );
  }
  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Color(0xFF7B51D3),
    ),
    child: Center(
      child: Text(
        'Do not Destroy',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}