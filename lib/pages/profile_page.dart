import 'package:everlast/pages/components/profile_menu.dart';
import 'package:everlast/pages/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:everlast/pages/my_account.dart';
import 'components/menu_pages/help.dart';
import 'components/menu_pages/notification.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(child: ProfilePic()),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ProfileMenu(
                      icon: "rout/images/user-03-svgrepo-com.svg",
                      text: "My Account",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyAccountPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ProfileMenu(
                      icon: "rout/images/notification-svgrepo-com.svg",
                      text: "Notifications",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ProfileMenu(
                      icon: "rout/images/settings-svgrepo-com.svg",
                      text: "Settings",
                      press: () {},
                    ),
                    SizedBox(height: 10),
                    ProfileMenu(
                      icon: "rout/images/help-svgrepo-com.svg",
                      text: "Help",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpPage(),
                          ),
                        );
                      },
                    ),
                     SizedBox(height: 10),
                    ProfileMenu(
                      icon: "rout/images/log-out-svgrepo-com.svg",
                      text: "Log Out",
                      press: () {},
                    ),
                    // SizedBox(height: 10),
                    // ProfileMenu(
                    //   icon: "rout/images/log-out-svgrepo-com.svg",
                    //   text: "Log Out",
                    //   press: () {},
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}