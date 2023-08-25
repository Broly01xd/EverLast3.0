import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:everlast/utils/historyandfurture_event_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/event_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _message = '';
  String? _uid;

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
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              width: 10,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Text(
                    "Memories",
                    style: TextStyle(
                      color: Colors.white,
                      height: 0.5,
                      wordSpacing: 10,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
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
                ),padding: const EdgeInsets.all(25),
                child: Container(
                  color: Color.fromARGB(255, 239, 234, 240),
                  child: Column(
                    children: [
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('events')
                              .where('id', isEqualTo: _uid)
                              .where('FromTime', isLessThan: Timestamp.now())
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
                            }



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
                                      'rout/images/hist.png', // Adjust the image path
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
            ),
            // ),
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
