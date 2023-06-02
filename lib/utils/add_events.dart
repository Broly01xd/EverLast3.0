import 'package:flutter/material.dart';
import 'package:share/share.dart';

class EventsTile extends StatelessWidget {
  final IconData icon;
  final String eventName;
  final String eventDate;
  final String eventWho;

  const EventsTile({
    Key? key,
    required this.icon,
    required this.eventName,
    required this.eventDate,
    required this.eventWho,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                    color: Color.fromARGB(255, 137, 35, 148),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15, height: 4),
                    ),
                    Text(
                      eventDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      eventWho,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.share_outlined),
                  onPressed: () {
                    Share.share(
                        "https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
                  },
                ),
                PopupMenuButton<String>(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                      PopupMenuItem<String>(
                        value: 'update',
                        child: Text('Update'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'delete') {
                      _showDeleteConfirmationDialog(context);
                    } else if (value == 'update') {
                      // Perform update operation
                    }
                  },
                  child: Icon(Icons.more_horiz),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform delete operation
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
