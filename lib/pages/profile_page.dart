import 'package:everlast/pages/components/profile_menu.dart';
import 'package:everlast/pages/components/profile_pic.dart';

import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(child: ProfilePic()),
            SizedBox(
              height: 20,
            ),
            ProfileMenu(
              icon: "rout/images/user-03-svgrepo-com.svg",
              text: "My Account",
              press: (){},
            ),
            ProfileMenu(
              icon: "rout/images/notification-svgrepo-com.svg",
              text: "Notifications",
              press: (){},
            ),
            ProfileMenu(
              icon: "rout/images/settings-svgrepo-com.svg",
              text: "Settings",
              press: (){},
            ),
            ProfileMenu(
              icon: "rout/images/help-svgrepo-com.svg",
              text: "Help",
              press: (){},
            ),
            ProfileMenu(
              icon: "rout/images/log-out-svgrepo-com.svg",
              text: "Log Out",
              press: (){},
            ),
          ],
        ));
  }
}

