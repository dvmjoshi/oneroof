import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Made With"),
              Icon(Icons.favorite,color: Colors.redAccent,),
            ],),
            RichText(
              text: TextSpan(
                text: 'By Nomad Dev ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[

                  TextSpan(text: 'Team members ' , style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Dvm and Mac'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
