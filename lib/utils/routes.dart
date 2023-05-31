import 'package:everlast/pages/otp_page.dart';
import 'package:flutter/material.dart';

import '../pages/add.dart';
import '../pages/error_page.dart';
import '../pages/gen_OTP.dart';
import '../pages/history_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/today_page.dart';
import '../pages/tom_page.dart';

class MyRoutes {
  static String genotpRoute = "/genotp";
  static String homeRoute = "/home";
  static String historyRoute = "/history";
  static String addRoute = "/add";
  static String profileRoute = "/profile";
  static String todayRoute = "/today";
  static String tomRoute = "/tomorrow";
  static String entrotpRoute = "/enterotp";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/genotp':
        return MaterialPageRoute(builder: (context) => const Genotp());
      case '/enterotp':
        return MaterialPageRoute(builder: (context) => const OtpPage());
      case '/history':
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      case '/add':
        return MaterialPageRoute(builder: (context) => const AddPage());
      case 'profile':
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case 'today':
        return MaterialPageRoute(builder: (context) => const TodayPage());
      case 'tomorrow':
        return MaterialPageRoute(builder: (context) => const TomPage());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}