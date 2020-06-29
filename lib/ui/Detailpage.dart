import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oneroof/Splashscreen/delayed_animation.dart';
import 'package:oneroof/video/videoPlayer1.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import 'HoverCard.dart';


class DetailPage extends StatefulWidget {
  final String imageurl;
  final String name;
  final String description;
  final String description2;
  final String videourl;
  final String videodes;
  final String category;
  final String subheading;
  final String facts;
  final Color verticalBorderColor;
  DetailPage(
      {Key key,
        @required this.imageurl,
        this.facts,
        this.name,
        this.description,
        this.category,
        this.videourl,
        this.videodes,
        this.description2,
        this.subheading,
        this.verticalBorderColor = Colors.blue})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  Animation opacityContainer;
  Animation translateDownContainer;
  Animation translateUpText;
  Animation opacityText;
  AnimationController animationController;

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addListener(() {
      setState(() {});
    });
    translateDownContainer =
        Tween(begin: Offset(0.0, 20), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(curve: Curves.easeIn, parent: animationController));
    opacityContainer = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
        parent: animationController));
    translateUpText = Tween(begin: Offset(0.0, -20), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      parent: animationController,
    ));
    opacityText = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.8, 0.9, curve: Curves.easeIn),
        parent: animationController));
    animationController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Hero(
              tag: widget.imageurl,
              child: Image(
                image: NetworkImage(widget.imageurl),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2 - 40,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 100,
            left: 20,
            child: Transform.translate(
              offset: translateDownContainer.value,
              child: Opacity(
                opacity: opacityContainer.value,
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 3,
                        height: 50,
                        color: widget.verticalBorderColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Text(
//                            widget.name.toUpperCase(),
//                            style: TextStyle(fontSize: 16, letterSpacing: 2),
//                          ),
//                          SizedBox(
//                            height: 20,
//                          ),
                          Container(
                            width: 200,
                            child: Text(
                              widget.name.toUpperCase(),
                              style:
                              TextStyle(fontFamily: "Butler", fontSize: 40),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Transform.translate(
                            offset: translateUpText.value,
                            child: Opacity(
                              opacity: opacityText.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      widget.description.trim(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                     widget.description2.trim(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: <Widget>[
                              Container(
                                child: RaisedButton(
                                  onPressed: () {
                                    Expanded(

                                      child: openBottomSheet(),
                                    );
                                  },
                                  color: Color(0xFF2B65F9),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_circle_outline,color: Colors.white,),
                                        Text(
                                          'Watch',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 40,
                                height: 2,
                                color: Colors.black,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );

  }
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Color(0xFF7B51D3),
    ),
    child: Center(
      child: Row(
        children: [
          Icon(Icons.play_circle_outline),
          Text(
            'Watch',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
  Widget openBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 25 ),
              child: Container(
                height: 690 ,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //(children: items, position: TimelinePosition.Center),
                    topBar(),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                        widget.name,
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 30 ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1 ,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:55.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.facts,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                      fontSize: 14 ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:125,left: 8,right: 8),
                      child: Center(
                        child: Text(
                          widget.videodes,
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14 ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    SizedBox(
                      height: 2 ,
                    ),

                    Spacer(),

                  ],
                ),
              ),
            ),
          );
        });

  }
  SizedBox topBar() {
    return SizedBox(
      height: 250,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[BlueBar(widget.videourl), MoviePoster(widget.imageurl)],
      ),
    );
  }
}
class BlueBar extends StatelessWidget {
  String videourl;

  BlueBar(this.videourl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 250),
      builder: (context, animation) {
        return Container(
          height: animation,
          width: double.infinity,
          child: videoplayer2(Url: videourl,),
        );
      },
    );
  }
}

class MoviePoster extends StatelessWidget {
  String image;

  MoviePoster(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: (300 * 2).round()),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticInOut,
      builder: (context, scalevalue) {
        return Positioned(
            top: 190,
            left: 0,
            child: Transform.scale(
              scale: scalevalue,
              alignment: Alignment.center,
              child:  Container(
                width: 100,
                height: 150,
                margin: EdgeInsets.only(left: 10, top: 70),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.5, 1.0),
                          blurRadius: 5,
                          color: Colors.white)
                    ]
                ),
                child: HoverCard(
                  builder: (context, hover) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(image, fit: BoxFit.cover),
                    );
                  },
                  depth: 0,
                  depthColor: Colors.transparent,
                  shadow: BoxShadow(
                    color: Colors.black.withAlpha(0x80),
                    blurRadius: 30,
                    spreadRadius: -20,
                    offset: Offset(0, 50),
                  ),
                ),
              ),
//            Container(
//              height: 140,
//              width: 100,
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: AssetImage(image),
//                    fit: BoxFit.cover,
//                  ),
//                  borderRadius: BorderRadius.circular(6.0),
//                  boxShadow: [
//                    BoxShadow(
//                        offset: Offset(0.5, 1.0),
//                        blurRadius: 5,
//                        color: Colors.white)
//                  ]),
//            ),
//          ),
            ));
      },
    );
  }
}
