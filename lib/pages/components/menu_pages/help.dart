import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../profile_menu.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  void openAppVersionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppVersionPage(appVersion: appVersion),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Help',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'App Version:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 8),
            ProfileMenu(
              icon: "rout/images/settings-svgrepo-com.svg",
              text: "App Version",
              press: () {
                openAppVersionPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppVersionPage extends StatelessWidget {
  final String appVersion;

  const AppVersionPage({Key? key, required this.appVersion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Version'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          appVersion,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
