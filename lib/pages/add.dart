import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/arguments/card_page_arguments.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/utils/add_events.dart';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/event_model.dart';

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
                const Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Text(
                    "Eventify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
              child: Container(
                 decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.all(25),


                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('events')
                      .where('id', isEqualTo: _uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // return Text('Loading...');
                      return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ListView.builder(
                                itemCount:
                                    5, 
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return EventsTileShimmer();
                                },
                              ),
                            );
                    }
                    final data = snapshot.requireData;

                     if (data.docs.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   
                                    const SizedBox(height: 5),
                                    Image.asset(
                                      'rout/images/123.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  ],
                                ),
                              );
                            }



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
