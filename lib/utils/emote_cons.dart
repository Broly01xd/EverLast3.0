import 'package:flutter/material.dart';

class EmoticonFace extends StatefulWidget {
  final String emoticonFace;

  const EmoticonFace({
    Key? key,
    required this.emoticonFace,
  }) : super(key: key);

  @override
  _EmoticonFaceState createState() => _EmoticonFaceState();
}

class _EmoticonFaceState extends State<EmoticonFace> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.purple[600],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            widget.emoticonFace,
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
