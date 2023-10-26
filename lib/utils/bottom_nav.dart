import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      onTap: onTap,
      backgroundColor:
          Colors.transparent, // You can set the desired background color here
      color: Colors.purple, // The active item's color
      buttonBackgroundColor:
          Colors.purple, // The background color of the center button
      height: 45, // Adjust the height as per your requirement
      items: const [
        Icon(
          Icons.today,
          size: 25,
          color: Colors.white,
        ),
        Icon(
          Icons.history,
          size: 25,
          color: Colors.white,
        ),
        Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
        Icon(
          Icons.event_available,
          size: 25,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 25,
          color: Colors.white,
        ),
      ],
    );
  }
}
