import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/history_page.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/bottom_nav.dart';
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

  @override
  initState() {
    super.initState();
    _currentIndex = widget.index;
    _pageController = PageController(initialPage: _currentIndex);
    // Add listeners to this class
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          children: [
            TodayPage(),
            const HistoryPage(),
            const AddPage(),
            const TomPage(),
            const ProfilePage(),
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
      ),
    );
  }
}
