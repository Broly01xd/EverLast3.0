import 'package:everlast/utils/emote_cons.dart';
import 'package:everlast/utils/today_events_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
          child: Column(
        children: [
          //greetings row
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
                        //hi ----user
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
                    //Notification
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.blue[600],
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      padding: EdgeInsets.all(12),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i.ibb.co/bvHR444/IMG-2925.jpg"),
                        radius: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Feel Like Attending An Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //--->'emotes modes'
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        EmoticonFace(
                          emoticonFace: '😔',

                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'BAD',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        EmoticonFace(
                          emoticonFace: '🙂',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'FINE',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        EmoticonFace(
                          emoticonFace: '😀',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'WELL',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        EmoticonFace(
                          emoticonFace: '😚',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'EXCELLENT',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
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
                    //events heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Events",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Icon(Icons.more_horiz,),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //list view of events
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
                            eventName: 'Political speach',
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
