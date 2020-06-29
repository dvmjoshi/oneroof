import 'package:flutter/material.dart';
import 'package:oneroof/ui/HomePage.dart';
import 'package:oneroof/ui/navbar.dart';

import 'Splashscreen/splashpage.dart';
import 'lifelesson/checkauth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        "/HomePage":(BuildContext context)=> new HomePage(),
            "/navbar":(BuildContext context)=>new NavBar(),
        "/login":(BuildContext context)=>new CheckAuth()

      },
    );
  }
}

