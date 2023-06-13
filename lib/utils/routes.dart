import 'package:everlast/pages/otp_page.dart';
import 'package:flutter/material.dart';
import '../pages/my_account.dart';
import '../pages/bottom_nav_pages.dart';
import '../pages/card.dart';
import '../pages/create_event.dart';
import '../pages/error_page.dart';
import '../pages/gen_OTP.dart';
import '../pages/history_page.dart';
import '../pages/profile_page.dart';
import '../pages/today_page.dart';
import '../pages/tom_page.dart';
import '../pages/user_details.dart';
import '../pages/Upload_invi.dart';


class MyRoutes {
  static String genotpRoute = "/genotp";
  static String botnavRoute = "/BotNavPage";
  static String historyRoute = "/history";
  static String addRoute = "/add";
  static String profileRoute = "/profile";
  static String todayRoute = "/today";
  static String cadrRoute = "/card";
  static String UploadinviRoute = "/Uploadinvi";
  static String tomRoute = "/tomorrow";
  static String entrotpRoute = "/enterotp";
  static String createventRoute = "/create";
  static String UserdetailsRoute = "/Userdetails";
  static String MyAccountPageRoute = "/MyAccountPage";
  static String OtpPageRoute = "/OtpPage";
  


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/BotNavPage':
        return MaterialPageRoute(builder: (context) =>BotNavPage(index:0));
        case '/Uploadinvi':
        return MaterialPageRoute(builder: (context) =>Uploadinvi());
        case '/Userdetails':
        return MaterialPageRoute(builder: (context) =>Userdetails());
      case '/genotp':
        return MaterialPageRoute(builder: (context) => Genotp());
      case '/enterotp':
        return MaterialPageRoute(builder: (context) => OtpPage());
      case '/history':
        return MaterialPageRoute(builder: (context) => BotNavPage(index:1));
      case '/add':
        return MaterialPageRoute(builder: (context) => BotNavPage(index:2));
      case '/profile':
        return MaterialPageRoute(builder: (context) => BotNavPage(index:4));
      case '/today':
        return MaterialPageRoute(builder: (context) => BotNavPage(index: 0));
      case '/tomorrow':
        return MaterialPageRoute(builder: (context) =>  BotNavPage(index: 3));
         case '/card':
        return MaterialPageRoute(builder: (context) => CardPage());
      case '/create':
        return MaterialPageRoute(builder: (context) => CreateEvent());
      case '/MyAccountPage':
        return MaterialPageRoute(builder: (context) => MyAccountPage());
      case '/OtpPage':
        return MaterialPageRoute(builder: (context) => OtpPage());
        
      default:
        return MaterialPageRoute(builder: (context) => ErrorPage());
    }
  }
}
