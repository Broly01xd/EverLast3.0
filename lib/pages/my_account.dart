import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  List<String> eventNames = [
    'Event 1',
    'Event 2',
    'Event 3',
    'Event 4',
  ];

  String selectedEventName = 'Event 1'; // Default selected value

  void handleDropdownValueChanged(String newValue) {
    setState(() {
      selectedEventName = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'ABC DEF',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'abc.def@example.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            ElevatedButton(
              child: Text('Change Password'),
              onPressed: () {
                Navigator.pushNamed(context, '/change_password');
              },
            ),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
           
           
          ],
        ),
      ),
    );
  }
}
