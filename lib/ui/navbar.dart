import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:oneroof/lifelesson/checkauth.dart';
import 'package:oneroof/lifelesson/firbase.dart';

import 'HomePage.dart';
import 'aboutus.dart';
class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  List tabs=[
    HomePage(),
    home(),
    AboutUs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
        bottomNavigationBar: FFNavigationBar(
    theme: FFNavigationBarTheme(
    barBackgroundColor: Colors.white,
      selectedItemBorderColor: Colors.transparent,
      selectedItemBackgroundColor: Colors.green,
      selectedItemIconColor: Colors.white,
      selectedItemLabelColor: Colors.black,
      showSelectedItemShadow: false,
      barHeight: 50,
    ),
    selectedIndex: selectedIndex,
    onSelectTab: (index) {
    setState(() {
    selectedIndex = index;
    });
    },
    items: [
    FFNavigationBarItem(
    iconData: Icons.home,
    label: 'Home',

    ),
    FFNavigationBarItem(
    iconData: Icons.transfer_within_a_station,
    label: 'Lesson',
    selectedBackgroundColor: Colors.grey,
    ),
    FFNavigationBarItem(
    iconData: Icons.people,
    label: 'About us',
    selectedBackgroundColor: Colors.blueGrey,
    ),
    ],
    ),
    );
  }
}
