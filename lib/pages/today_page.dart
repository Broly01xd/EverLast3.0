import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/utils/add_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/event_model.dart';
import '../provider/auth_provider.dart';
// import '../utils/today_events_tile.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  String _message = '';
  String? _uid;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _message = 'Initialization complete';
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String uname = ap.userModel.name;
    _uid = ap.getCurrentUserUid();
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
                          Text(
                            'Hi, $uname!',
                            style: const TextStyle(
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
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              ap.userModel.profileImage,
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
                    _selectedDate,
                    onDateChange: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
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
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('events')
                              .where('id', isEqualTo: _uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...');
                            }

                            final data = snapshot.requireData;
                            final List<EventModel> eventModels = [];
                            final List<String> documentIds = [];

                            for (var docSnapshot in data.docs) {
                              final eventModel =
                                  EventModel.fromFirestore(docSnapshot);
                              final documentId = docSnapshot.id;

                              final Timestamp firestoreTimestamp =
                                  docSnapshot.data()['FromTime'] as Timestamp;
                              final DateTime eventDate =
                                  firestoreTimestamp.toDate();

                              if (_selectedDate.year == eventDate.year &&
                                  _selectedDate.month == eventDate.month &&
                                  _selectedDate.day == eventDate.day) {
                                eventModels.add(eventModel);
                                documentIds.add(documentId);
                                print('Document ID: $documentId');
                                print('Event Model: $eventModel');
                                print('Date in Firestore: $firestoreTimestamp');
                                print('Selected Date: $_selectedDate');
                              }
                            }

                            if (eventModels.isEmpty) {
                              return const Text(
                                  "No events found for selected date");
                            }

                            return ListView.builder(
                              itemCount: eventModels.length,
                              itemBuilder: (BuildContext context, int index) {
                                final eventModel = eventModels[index];
                                final documentId = documentIds[index];
                                print('Rendering Event: $documentId');

                                return EventsTile(
                                  docId: '',
                                  imageAsset: eventModel.eventPic,
                                  eventName: eventModel.eventName,
                                  eventWho: eventModel.name,
                                  onDeletePressed: () {},
                                  onUpdatePressed: () {},
                                  onPressed: () {},
                                );
                              },
                            );
                          },
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
