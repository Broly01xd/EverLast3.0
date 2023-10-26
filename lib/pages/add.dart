import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/utils/add_events.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../arguments/card_page_argument.dart';
import '../model/event_model.dart';
import '../provider/auth_provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<AddPage> {
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
    _uid = ap.getCurrentUserUid();

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Eventify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.createventRoute);
                      },
                      child: const Column(
                        children: [
                          Text(
                            'Create',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            'New',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        primary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: Color.fromARGB(255, 239, 234, 240),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('events')
                        .where('id', isEqualTo: _uid)

                        //  .where('joined_user', arrayContains: _uid)
                        // .where('FromTime', isNotEqualTo: Timestamp.now())
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final eventModel =
                              EventModel.fromFirestore(data.docs[index]);
                          final documentId = data.docs[index].id;
                          return EventsTile(
                            docId: documentId,
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
                            onDeletePressed: () {
                              _showDeleteConfirmationDialog(
                                  context, documentId);
                            },
                            onUpdatePressed: () {
                              // Perform update operation
                              Navigator.pushNamed(
                                context,
                                MyRoutes.createventRoute,
                                arguments: CardPageArgument(
                                  documentId: documentId,
                                  eventModel: eventModel,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String? eventId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () async {
                // Perform delete operation
                if (eventId != null) {
                  await FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventId)
                      .delete();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
