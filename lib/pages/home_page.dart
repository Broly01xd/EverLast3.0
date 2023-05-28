import 'package:flutter/material.dart';
import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/history_page.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  final int days = 30;
  final String name = "";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          TodayPage(),
          HistoryPage(),
          AddPage(),
          TomPage(),
          ProfilePage(),

        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index){
          _pageController.animateToPage(index, duration: Duration(microseconds: 1000), curve: Curves.ease);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.today),
            title: Text("Today"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
            selectedColor: Colors.pink,
          ),

          ///
          SalomonBottomBarItem(
            icon: Icon(Icons.add),
            title: Text("Add"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.event_available),
            title: Text("Events"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}
