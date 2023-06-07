import 'package:everlast/pages/otp_page.dart';
import 'package:flutter/material.dart';

import '../pages/add.dart';
import '../pages/bottom_nav_pages.dart';
import '../pages/card.dart';
import '../pages/create_event.dart';
import '../pages/error_page.dart';
import '../pages/gen_otp.dart';
import '../pages/history_page.dart';
import '../pages/my_account.dart';
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
  static String createventRoute = "/create";
  static String MyAccountPageRoute = "/MyAccountPage";
  static String CardRoute = "/card";
  static String bottomnavRoute = "/bottomNav";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/bottomNav':
        return MaterialPageRoute(builder: (context) => BotNavPage());
      case '/genotp':
        return MaterialPageRoute(builder: (context) => Genotp());
      case '/enterotp':
        return MaterialPageRoute(builder: (context) => OtpPage());
      case '/history':
        return MaterialPageRoute(builder: (context) => HistoryPage());
      case '/add':
        return MaterialPageRoute(builder: (context) => AddPage());
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case '/today':
        return MaterialPageRoute(builder: (context) => TodayPage());
      case '/tomorrow':
        return MaterialPageRoute(builder: (context) => TomPage());
      case '/create':
        return MaterialPageRoute(builder: (context) => CreateEvent());
      case '/card':
        return MaterialPageRoute(builder: (context) => CardPage());
      case '/MyAccountPage':
        return MaterialPageRoute(builder: (context) => MyAccountPage());
      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }
}
