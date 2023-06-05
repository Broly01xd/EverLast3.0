import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/history_page.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/bottom_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

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
      drawer: const Drawer(),
    );
  }
}
