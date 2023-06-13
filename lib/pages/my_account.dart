import 'package:flutter/material.dart';
import 'package:everlast/pages/profile_page.dart';

class MyAccountPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(250),
                        bottomRight: Radius.circular(250),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 130,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        " My Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),



                  ),
                ],
              ),
            ),
            Expanded(
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
            // SizedBox(height: 10),
            // Text(
            //   'abc.def@example.com',
            //   style: TextStyle(fontSize: 16),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.pushNamed(context, '/Userdetails');
              },
            ),
            // ElevatedButton(
            //   child: Text('Change Password'),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/change_password');
            //   },
            // ),
            // ElevatedButton(
            //   child: Text('Logout'),
            //   onPressed: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       '/genotp',
            //   (route) => false,
            //      );
            //   },
            // ),
           
          ],
        ),
      ),
          ],
       ),
      ),
    );
  }
}


      
        
 



