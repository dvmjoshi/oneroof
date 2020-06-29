import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserData extends StatelessWidget {

  final String Image;
  final String Name;
  final String  description;
  final String id;
  String uidn;
  Future<void> _gtuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    uidn = user.uid;
print("i am uid ${uidn}");
  }
  UserData({
    Key key, this.Image, this.Name,this.description,this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
_gtuid();
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0,12,28,12),
      child: new Container(
        width: double.infinity,
        height: 420.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey.withOpacity(.3), width: .2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(Image,),
                  fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20.0)
                ),

              ),
            ),
            //Image.asset(imgUrl, width: 281.0, height: 191.0),
            Column(
              children: <Widget>[
                Text(Name, style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(description,
                      style: TextStyle(
                          color: Color(0xFFfeb0ba),
                          fontSize: 20.0,
                          fontFamily: "Helvetica")),
                ),

              ],
            ),
            SizedBox(
              height: 4.0,
            ),


          ],
        ),
      ),
    );
  }
}