import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/utils/today_events_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';


class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          children: [
            // Greetings row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hi ----user
                          Text(
                            'Hi, Hilal!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '23 jan,2021',
                            style: TextStyle(color: Colors.purple[100]),
                          ),
                        ],
                      ),
                      // Notification
                      Container(
                        padding: EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the profile page
                            // You can use a navigation library like Navigator to navigate to the desired page
                            // For example:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://i.ibb.co/bvHR444/IMG-2925.jpg",
                            ),
                            radius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Calendar
                  DatePicker(

                    DateTime.now(),
                    onDateChange: (date) {
                      // Handle date selection
                    },
                    selectedTextColor: Colors.black,
                    selectionColor: Colors.orange,
                    deactivatedColor: Colors.grey,
                    dayTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    dateTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    monthTextStyle: TextStyle(
                      color: Colors.white,
                    ),

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            // Today events begin
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      // Events heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Events",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // List view of events
                      Expanded(
                        child: ListView(
                          children: [
                            EventsTile(
                              icon: Icons.cake,
                              eventName: 'Birthday Party',
                              eventWho: 'Lua Dipa',
                            ),
                            EventsTile(
                              icon: Icons.man,
                              eventName: 'Political speech',
                              eventWho: 'Morendra Nodi',
                            ),
                            EventsTile(
                              icon: Icons.book,
                              eventName: 'Seminar',
                              eventWho: 'Salmon Boi',
                            ),
                            EventsTile(
                              icon: Icons.business,
                              eventName: 'Company meetings',
                              eventWho: 'Microsoft',
                            ),
                            EventsTile(
                              icon: Icons.party_mode_sharp,
                              eventName: 'Company party',
                              eventWho: 'GuluGulu',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
