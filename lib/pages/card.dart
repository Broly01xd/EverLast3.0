import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/pages/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/notification_api.dart';
import '../model/event_model.dart';
import '../provider/auth_provider.dart';
import 'bottom_nav_pages.dart';

class CardPage extends StatefulWidget {
  final String documentId;
  final bool openedFromDynamicLink;
  const CardPage(
      {Key? key, required this.documentId, this.openedFromDynamicLink = false})
      : super(key: key);
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var color1 = const Color.fromARGB(255, 139, 89, 148);
  var color2 = Colors.white;
  // late EventModel eventModel;
  String imgUrl = '';
  late String toDateStr;
  late String fromDateStr;
  late String fromTimeStr;
  late String toTimeStr;
  late final ap;
  DateTime scheduleTime = DateTime.now();

  @override
  void initState() {
    ap = Provider.of<AuthProvider>(context, listen: false);
    // DynamicLinkProvider().initDynamicLink(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Invitation Card'.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .doc(widget.documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data != null && !snapshot.data!.exists) {
              return const Center(
                child: Text('Document does not exist'),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('Document does not exist'),
              );
            }
            final eventModel = EventModel.fromMap(snapshot.data!.data()!);
            toDateStr =
                DateFormat('yyyy-MM-dd ').format(eventModel.toTime.toDate());
            fromDateStr =
                DateFormat('yyyy-MM-dd ').format(eventModel.fromTime.toDate());
            fromTimeStr = DateFormat('HH:mm:ss')
                .format(eventModel.fromTime.toDate())
                .toString();
            toTimeStr = DateFormat('HH:mm:ss')
                .format(eventModel.toTime.toDate())
                .toString();
            imgUrl = eventModel.eventPic;
            return Stack(
              fit: StackFit.expand,
              children: [
                if (imgUrl != '')
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.lerp(const Radius.circular(0),
                          const Radius.circular(20), 0.5)!,
                      topRight: Radius.lerp(const Radius.circular(0),
                          const Radius.circular(20), 0.5)!,
                    ),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2)
                        ],
                        stops: const [
                          0.0,
                          0.0,
                          1.0
                        ]).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.purple]),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 65,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 14,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 180,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 90),
                                        Text(
                                          eventModel.eventName,
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: color2,
                                            fontWeight: FontWeight.w900,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          eventModel.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: color2,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.02),
                        // const SizedBox(height: 20),
                        const Icon(Icons.location_on,
                            color: Color.fromARGB(248, 247, 246, 248),
                            size: 35),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Center(
                            child: Text(
                              eventModel.location,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: color2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'From: $fromTimeStr',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 38),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'To: $toTimeStr',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'From : $fromDateStr',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'To : $toDateStr',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      // fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // arrowbutton
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final userId =
                                  user.uid; // Make sure userId is a string
                              final eventId = widget.documentId;

                              // Update the joinedUser array in Firestore
                              await FirebaseFirestore.instance
                                  .collection('events')
                                  .doc(eventId)
                                  .update({
                                'joined_user': FieldValue.arrayUnion(
                                    [userId]), // Use userId as a string
                              });

                              // Navigate to the desired page after joining
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BotNavPage(index: 2)),
                              );
                            } else {
                              print("User is not signed in");
                            }
                          },
                          //  Navigator.pushNamed(context, "/add");

                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: color1,
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            primary: color2,
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('events')
            .doc(widget.documentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const SizedBox.shrink();
          }

          final eventModel = EventModel.fromMap(snapshot.data!.data()!);
          final user = FirebaseAuth.instance.currentUser;
          print('user: ${user?.uid}');

          if (user == null) {
            return const SizedBox.shrink();
          }

          final isEventCreator = eventModel.id == user.uid;

          print(eventModel.joinedUser);

          if (isEventCreator) {
            return const SizedBox.shrink();
          }

          if (eventModel.joinedUser.contains(user.uid)) {
            return const SizedBox.shrink();
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (ap.isSignedIn == true) {
                        await ap.getDataFromSP();
                      }

                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final userId = user.uid; // Make sure userId is a string
                        final eventId = widget.documentId;

                        // Update the joinedUser array in Firestore
                        await FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .update({
                          'joined_user': FieldValue.arrayUnion(
                              [userId]), // Use userId as a string
                        });

                        final snapData = await FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .get();

                        final eventData = snapData.data()!;

                        final duration = eventData['duration'];
                        final eventName = eventData['EventName'];
                        final createrName = eventData['Name'];
                        final durationType = eventData['durationType'];

                        final time =
                            (eventData['FromTime'] as Timestamp).toDate();

                        final beforeTime = Duration(
                            minutes: durationType == 'minute' ? duration : 0,
                            hours: durationType == 'hour' ? duration : 0,
                            days: durationType == 'day' ? duration : 0);

                        NotificationApi.showScheduledNotification(

                            // Random().nextInt(10),
                            scheduleTime: time.subtract(beforeTime),
                            title: 'Event Reminder',
                            body: eventName + " by " + createrName);

                        // Navigate to the desired page after joining
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BotNavPage(index: 3)),
                        );
                      } else {
                        print("User is not signed in");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Accept',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Reject',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child(imagePath);
      final String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }
}
