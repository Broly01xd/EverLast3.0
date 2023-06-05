import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:everlast/utils/add_events.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(111),
                      bottomRight: Radius.circular(111),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Eventify",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 15,
                    left: 50,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create New",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/create");
                              // Add button onPressed logic here
                              print('Add button pressed');
                            },
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(8),
                              primary: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: const [
                  EventsTile(
                      icon: Icons.cake,
                      eventName: 'Birthday Party',
                      eventWho: '',
                      eventDate: ''),
                  // EventsTile(
                  //   icon: Icons.man,
                  //   eventName: 'Political speech',
                  //   eventDate: '',
                  //   eventWho: '',
                  // ),
                  // EventsTile(
                  //   icon: Icons.book,
                  //   eventName: 'Seminar',
                  //   eventDate: ' ',
                  //   eventWho: ' ',
                  // ),
                  // EventsTile(
                  //   icon: Icons.business,
                  //   eventName: 'Company meetings',
                  //   eventDate: ' ',
                  //   eventWho: ' ',
                  // ),
                  // EventsTile(
                  //   icon: Icons.party_mode_sharp,
                  //   eventName: 'Company party',
                  //   eventDate: ' ',
                  //   eventWho: ' ',
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
