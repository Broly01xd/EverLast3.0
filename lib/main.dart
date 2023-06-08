import 'package:flutter/material.dart';
import 'package:everlast/pages/today_page.dart';
import 'package:everlast/pages/add.dart';
import 'package:everlast/pages/profile_page.dart';
import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:everlast/pages/history_page.dart';
import 'package:everlast/pages/otp_page.dart';
import 'pages/bottom_nav_pages.dart';
import 'pages/create_event.dart';
import 'pages/invitation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: GoogleFonts.lato().fontFamily,
          primaryTextTheme: GoogleFonts.latoTextTheme()),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/genotp',
      onGenerateRoute: MyRoutes.generateRoute,
    );
  }
}
