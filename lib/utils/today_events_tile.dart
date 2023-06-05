import 'package:flutter/material.dart';
import 'package:everlast/pages/home_page.dart';

class EventsTile extends StatelessWidget {
  final String imageAsset;
  final String eventName;
  final String eventWho;

  const EventsTile({
    Key? key,
    required this.imageAsset,
    required this.eventName,
    required this.eventWho,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      border: Border.all(color: Colors.purple),
                      image: DecorationImage(
                        image: AssetImage(imageAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // color: Color.fromARGB(255, 137, 35, 148),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      eventWho,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                  const PopupMenuItem<String>(
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
              child: const Icon(Icons.more_horiz),
            ),
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
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform delete operation
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
