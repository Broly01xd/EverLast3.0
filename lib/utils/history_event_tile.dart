import 'package:flutter/material.dart';

class historyEventsTile extends StatelessWidget {
  final String imageAsset;
  final String eventName;
  final String eventWho;
  final Function() onPressed;
  final void Function() onCancelPressed;

  const historyEventsTile({
    super.key,
    required this.imageAsset,
    required this.eventName,
    required this.eventWho,
    required this.onPressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    print(eventName + eventWho + imageAsset);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
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
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageAsset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventName,
                            style: TextStyle(fontSize: 16),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            eventWho,
                            style: TextStyle(fontSize: 10),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: PopupMenuButton<String>(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'Cancel',
                        child: Text('Cancel'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'Cancel') {
                      onCancelPressed();
                    }
                    {
                      onCancelPressed();
                    }
                  },
                  child: const Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
