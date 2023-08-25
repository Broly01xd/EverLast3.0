import 'package:everlast/pages/components/menu_pages/setting.dart';
import 'package:everlast/pages/components/profile_menu.dart';
import 'package:everlast/pages/gen_OTP.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:everlast/pages/my_account.dart';
import 'package:provider/provider.dart';
import 'WelcomeScreen.dart';
import 'components/menu_pages/help.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () async {
                final ap = Provider.of<AuthProvider>(context, listen: false);
                await ap.userSignOut();
                // Navigator.of(context).pop();

                if (!mounted){
                  return;
                }
                
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Genotp()),
                    (route) => false);
              },
              child: const Text('Log Out'),
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

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final String _profilePic = ap.userModel.profileImage;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        color: Colors.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Preferences",
                  style: TextStyle(
                    color: Colors.white,
                    height: 0.5,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: Color.fromARGB(255, 226, 225, 226),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        InkWell(
                          child: Container(
                            child: _profilePic == null
                                ? const CircleAvatar(
                                    backgroundColor: Colors.purple,
                                    radius: 50,
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(_profilePic),
                                    radius: 50,
                                  ),
                          ),
                        ),
                        //Account Setting
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              //App Setting
                              const SizedBox(height: 10),
                              ProfileMenu(
                                  icon: "rout/images/settings-svgrepo-com.svg",
                                  text: "Settings",
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const settingPage(),
                                      ),
                                    );
                                  }),
                              //Help
                              const SizedBox(height: 10),
                              ProfileMenu(
                                icon: "rout/images/help-svgrepo-com.svg",
                                text: "Help",
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HelpPage(),
                                    ),
                                  );
                                },
                              ),
                              //LogOut
                              const SizedBox(height: 10),
                              ProfileMenu(
                                icon: "rout/images/log-out-svgrepo-com.svg",
                                text: "Log Out",
                                press: () {
                                  _showLogoutConfirmationDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
