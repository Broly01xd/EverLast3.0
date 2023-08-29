import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/event_model.dart';
import '../utils/today_events_tile.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';

class TodayPage extends StatefulWidget {
  TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  String _message = '';
  
  String _d1 = '', _d2 = '';
  bool _material3 = true;
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
    String formattedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());

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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, $uname!',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                              ' $formattedDate ',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
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
                  _datePicker((date) {
                    setState(() {
                      _selectedDate = date;
                      _d2 = DateFormat('dd MMM, yyyy').format(date);
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                //background color for events displaying
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Events",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('events')
                              .where('joined_user',
                                  arrayContains:
                                      _uid) // Check if user is in joinedUser array
                              .where('FromTime',
                                  isGreaterThanOrEqualTo: Timestamp.fromDate(
                                      _selectedDate)) // Filter events starting from selected date
                              .where('FromTime',
                                  isLessThan: Timestamp.fromDate(
                                      _selectedDate.add(Duration(
                                          days:
                                              1)))) // Filter events ending before the next day
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                                  return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ListView.builder(
                                  itemCount:
                                      5, // Adjust the number of shimmering items
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EventsTileShimmer();
                                  },
                                ),
                              );
                              // return 
                              // const Text('Loading...');
                            }
                            final data = snapshot.requireData;
                            final List<EventModel> eventModels = [];
                            final List<String> documentIds = [];
                            for (var docSnapshot in data.docs) {
                              final eventModel =
                                  EventModel.fromFirestore(docSnapshot);
                              final documentId = docSnapshot.id;

                              final Timestamp firestoreTimestamp =
                                  docSnapshot.data()['FromTime'];
                              final DateTime eventDate =
                                  firestoreTimestamp.toDate();

                              if (_isSameDate(_selectedDate, eventDate)) {
                                eventModels.add(eventModel);
                                documentIds.add(documentId);
                              }
                            }
                            if (eventModels.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 5),
                                    Image.asset(
                                      'rout/images/sadu.png', // Adjust the image path
                                      width: 200,
                                      height: 200,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: eventModels.length,
                              itemBuilder: (BuildContext context, int index) {
                                final eventModel = eventModels[index];
                                final documentId = documentIds[index];
                                return TodayEventsTile(
                                  onPressed: () {
                              Navigator.pushNamed(
                                context,
                                MyRoutes.cardRoute,
                                arguments: documentId,
                              );
                            },
                                  imageAsset: eventModel.eventPic,
                                  eventName: eventModel.eventName,
                                  eventWho: eventModel.name,
                                  onCancelPressed: () {},
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

bool _isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Widget _datePicker(void Function(DateTime) onDateChanged) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 16),
      DateTimePicker(
        type: DateTimePickerType.Date,
        onDateChanged: onDateChanged,
        
      ),
    ],
  );
}

class EventsTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:  Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 5),
                Container(
                  width: 100,
                  height: 15,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}