import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/utils/historyandfurture_event_tile.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/event_model.dart';


class TomPage extends StatefulWidget {
  const TomPage({Key? key}) : super(key: key);

  @override
  State<TomPage> createState() => _TomPageState();
}

class _TomPageState extends State<TomPage> {
  String _message = '';
  String? _uid;

  @override
  void initState() {
    super.initState();
    _message = 'Initialization complete';
    // _uid =
    //     Provider.of<AuthProvider>(context, listen: false).getCurrentUserUid();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String uname = ap.userModel.name;
    _uid = ap.getCurrentUserUid();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            const Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Text(
                    "Upcoming ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "Events",
                  style: TextStyle(
                    color: Color.fromARGB(255, 70, 9, 77),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                child: Column(
                  children: [
                    Expanded(
                      child:
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('events')
                            .where('joined_user', arrayContains: _uid)
                             .where('FromTime', isGreaterThan: Timestamp.now())
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
                            // return const Text('Loading...');
                          }
                          late List<EventModel> eventModels = [];
                          late List<String> documentIds = [];

                          for (var docSnapshot in snapshot.data!.docs) {
                            final eventModel =
                                EventModel.fromFirestore(docSnapshot);
                            final documentId = docSnapshot.id;

                            eventModels.add(eventModel);
                            documentIds.add(documentId);
                            print("event model" + eventModel.toString());
                          }
                          print(eventModels.length);




                            if (eventModels.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const Text(
                                    //   "No events found for selected date",
                                    //   style: TextStyle(
                                    //     fontSize: 18,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    const SizedBox(height: 5),
                                    Image.asset(
                                      'rout/images/upcoming.png', // Adjust the image path
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
                              print('doc id -> $documentId');

                              return AllEventsTile(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, MyRoutes.cardRoute,
                                      arguments: documentId);
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
          ],
        ),
      ),
    );
  }
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
              color: Colors.grey[300],
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