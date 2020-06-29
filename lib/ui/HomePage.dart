import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneroof/data/oneroofdata.dart';
import 'package:oneroof/lifelesson/checkauth.dart';
import 'package:oneroof/video/videoPlayer1.dart';
import 'package:oneroof/video/videoplayer.dart';

import 'Detailpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Way to home",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        )),
                    background:Stack(
                      children: <Widget>[
                        videoplayer(),

                      ],
                    )),
              ),
            ];
          },
          body:Padding(
              padding: EdgeInsets.only(top: 40),
              child: _showdata(context)),));
  }
  Widget _showdata(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("home").snapshots(),
        builder: (context,snapshot) {
          if(!snapshot.hasData)return LinearProgressIndicator();
          return _builtList(context, snapshot.data.documents);
        }
    );
  }
  Widget _builtList(BuildContext context,List<DocumentSnapshot> snapshot){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children:snapshot.map((data) => _showCanddateList(context, data)).toList(),
      ),
    );

  }
  Widget _showCanddateList(BuildContext context, DocumentSnapshot data){{
    final record=OneRoofRecord.fromSnapshot(data);
    return Padding(
      key:ValueKey(record.name),
      padding: EdgeInsets.all(8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){

            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>DetailPage
              (imageurl: record.imageurl,name: record.name,description: record.description,
            videodes: record.videodes,videourl: record.videourl,description2: record.description2,category: record.category,facts:record.facts,)),
            );
                  },

                  child: Hero(
                    tag: record.imageurl,
                    child: Container(
                      height: 210,
                      width: 350,
                      margin: EdgeInsets.only(left: 0, right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(record.imageurl),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 3,
                            color: Colors.blue[900].withOpacity(0.1),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(record.name,
                    style: TextStyle(color: Colors.blueAccent,
                        fontSize: 12,fontWeight: FontWeight.bold),),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                  ),
                  label: Text(record.category),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(record.subheading,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(record.description,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),),
            ),
            Divider(thickness: 1,)
          ],

        ),
      ),);
  }
  }
}
