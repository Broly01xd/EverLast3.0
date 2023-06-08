import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../utils/today_events_tile.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          children: [
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
                          const Text(
                            'Hi, Hilal!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '23 Jan, 2021',
                            style: TextStyle(color: Colors.purple[100]),
                          ),
                        ],
                      ),
                      //profile
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "",
                            ),
                            radius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DatePicker(
                    DateTime.now(),
                    onDateChange: (date) {
                      // Handle date selection
                    },
                    selectedTextColor: Colors.black,
                    selectionColor: Colors.orange,
                    deactivatedColor: Colors.grey,
                    dayTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    dateTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    monthTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
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
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: const [
                            EventsTile(
                              imageAsset: 'rout/images/750997891.jpg',
                              eventName: 'Birthday Party',
                              eventWho: 'Lua Dipa',
                            ),
                            EventsTile(
                              imageAsset:
                                  'rout/images/Prime-Minister-Narendra-Modi---PTI-_1685268448404.avif',
                              eventName: 'Political speech',
                              eventWho: 'Morendra Nodi',
                            ),
                            EventsTile(
                              imageAsset: 'rout/images/seminar.jpg',
                              eventName: 'Seminar',
                              eventWho: 'Salmon Boi',
                            ),
                            EventsTile(
                              imageAsset: 'rout/images/microsoft-logo.webp',
                              eventName: 'Company meetings',
                              eventWho: 'Microsoft',
                            ),
                            EventsTile(
                              imageAsset: 'rout/images/unnamed.png',
                              eventName: 'Company party',
                              eventWho: 'GuluGulu',
                            ),
                            EventsTile(
                              imageAsset:
                                  'rout/images/Wedding-cost-in-India-Explained-Cover-Image.jpg',
                              eventName: 'Wedding',
                              eventWho: 'Unmarried Person',
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
