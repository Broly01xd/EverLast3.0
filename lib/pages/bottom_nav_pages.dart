import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/history_page.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/bottom_nav.dart';
import 'package:everlast/utils/today_events_tile.dart';
import 'package:flutter/material.dart';

class BotNavPage extends StatefulWidget {
 final index;
  const BotNavPage({super.key, this.index = 0});

  @override
  _BotNavPageState createState() => _BotNavPageState();



}

class _BotNavPageState extends State<BotNavPage> {
  late PageController _pageController;
 late var _currentIndex;
  initState() {
  super.initState();
   _currentIndex = widget.index;
    _pageController = PageController(initialPage: _currentIndex);
 // Add listeners to this class
}
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
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
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
      // drawer: const Drawer(),
    );
  }
}