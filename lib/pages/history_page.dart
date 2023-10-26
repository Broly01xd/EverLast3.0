import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/utils/history_event_tile.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/event_model.dart';
import '../provider/auth_provider.dart';

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
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Memories",
                  style: TextStyle(
                    color: Colors.white,
                    height: 0.5,
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
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
                              return const Text('Loading...');
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
                            return ListView.builder(
                              itemCount: eventModels.length,
                              itemBuilder: (BuildContext context, int index) {
                                final eventModel = eventModels[index];
                                final documentId = documentIds[index];
                                print('doc id -> $documentId');

                                return historyEventsTile(
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
