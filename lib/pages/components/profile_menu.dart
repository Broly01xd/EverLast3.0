import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });
  final String text, icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 22,
                colorFilter:
                    const ColorFilter.mode(Colors.orange, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.black,
              ),
            ],
          )),
    );
  }
}