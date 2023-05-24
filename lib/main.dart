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

      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch:Colors.purple,
          fontFamily: GoogleFonts.lato().fontFamily,
          primaryTextTheme:GoogleFonts.latoTextTheme()),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes:{

        "/":(context) => loginpage(),

        MyRoutes.homeRoute:(context) => HomePage(),
        MyRoutes.loginRoute:(context) => TodayPage(),
        MyRoutes.historyRoute:(context) => HistoryPage(),
        MyRoutes.loginRoute:(context) => AddPage(),
        MyRoutes.loginRoute:(context) => TomPage(),
        MyRoutes.loginRoute:(context) => ProfilePage()
      },
    );
  }
}



