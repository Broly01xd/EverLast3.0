import 'package:flutter/material.dart';
import 'package:everlast/pages/login_page.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everlast/pages/history_page.dart';

import 'pages/home_page.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes:{

        "/":(context) => loginpage(),

        MyRoutes.homeRoute:(context) => HomePage(),
        MyRoutes.todayRoute:(context) => TodayPage(),
        MyRoutes.historyRoute:(context) => HistoryPage(),
        MyRoutes.addRoute:(context) => AddPage(),
        MyRoutes.tomRoute:(context) => TomPage(),
        MyRoutes.profileRoute:(context) => ProfilePage()
      },
    );
  }
}



