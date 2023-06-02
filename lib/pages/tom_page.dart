import 'package:everlast/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:everlast/utils/tom_events_tile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class TomPage extends StatelessWidget {
  const TomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Upcoming ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Events",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    // Action for Personal Events button
                  },
                  icon: Icon(Icons.person),
                  label: Text('Personal'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Action for Community Events button
                  },
                  icon: Icon(Icons.group),
                  label: Text('Social'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Action for Professional Events button
                  },
                  icon: Icon(Icons.business),
                  label: Text('Work'),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(85)),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: const [
                            EventsTile(
                                icon: Icons.cake,
                                eventName: 'Birthday Party',
                                eventWho: 'Lua Dipa',
                                eventDate: '15/2/2023'),
                            EventsTile(
                              icon: Icons.man,
                              eventName: 'Political speech',
                              eventDate: '15/2/2023',
                              eventWho: 'Morendra Nodi',
                            ),
                            EventsTile(
                              icon: Icons.book,
                              eventName: 'Seminar',
                              eventDate: '15/2/2023',
                              eventWho: 'Salmon Boi',
                            ),
                            EventsTile(
                              icon: Icons.business,
                              eventName: 'Company meetings',
                              eventDate: '15/2/2023',
                              eventWho: 'Microsoft',
                            ),
                            EventsTile(
                              icon: Icons.party_mode_sharp,
                              eventName: 'Company party',
                              eventDate: '15/2/2023',
                              eventWho: 'GuluGulu',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
