import 'package:everlast/utils/dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class EventsTile extends StatelessWidget {
  final String docId;
  final String imageAsset;
  final String eventName;
  final String eventWho;
  final Function() onPressed;
  final void Function() onDeletePressed;
  final void Function() onUpdatePressed;

  const EventsTile({
    Key? key,
    required this.docId,
    required this.imageAsset,
    required this.eventName,
    required this.eventWho,
    required this.onPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          //  width: 50,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:FadeInImage(
                          image: NetworkImage(imageAsset),
                          placeholder: const AssetImage('rout/images/placeholder.jpeg'),
                          height: 48,
                          width: 48,
                        ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      // width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
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
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle share button pressed
                      print("button pressed");
                      DynamicLinkProvider()
                          .createLink(docId, isShortLink: false)
                          .then((value) {
                        Share.share(value);
                      });
                      // Add your share functionality here
                    },
                    icon: const Icon(Icons.share),
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
                        onDeletePressed();
                      } else if (value == 'update') {
                        onUpdatePressed();
                      }
                    },
                    child: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
