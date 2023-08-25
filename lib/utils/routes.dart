import 'package:everlast/arguments/card_page_arguments.dart';
import 'package:everlast/pages/otp_page.dart';
import 'package:everlast/wrapper.dart';
import 'package:flutter/material.dart';
import '../pages/WelcomeScreen.dart';
import '../pages/my_account.dart';
import '../pages/bottom_nav_pages.dart';
import '../pages/card.dart';
import '../pages/create_event.dart';
import '../pages/error_page.dart';
import '../pages/gen_OTP.dart';
import '../pages/user_details.dart';

class MyRoutes {
  static String welcomeRoute = "/welcome";
  static String wrapperRoute = "/wrapper";
  static String genotpRoute = "/genotp";
  static String botnavRoute = "/BotNavPage";
  static String historyRoute = "/history";
  static String addRoute = "/add";
  static String profileRoute = "/profile";
  static String todayRoute = "/today";
  static String cardRoute = "/card";
  static String tomRoute = "/tomorrow";
  static String entrotpRoute = "/enterotp";
  static String createventRoute = "/create";
  static String UserdetailsRoute = "/Userdetails";
  static String MyAccountPageRoute = "/MyAccountPage";
  static String OtpPageRoute = "/OtpPage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case '/wrapper':
        return MaterialPageRoute(builder: (context) => const Wrapper());
      case '/BotNavPage':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 0));
      case '/Userdetails':
        return MaterialPageRoute(
            builder: (context) => const UserInfromationScreen());
      case '/genotp':
        return MaterialPageRoute(builder: (context) => const Genotp());
      case '/enterotp':
        return MaterialPageRoute(
            builder: (context) => const OtpPage(
                  verificationId: '',
                ));
      case '/history':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 1));
      case '/add':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 2));
      case '/profile':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 4));
      case '/today':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 0));
      case '/tomorrow':
        return MaterialPageRoute(
            builder: (context) => const BotNavPage(index: 3));

      case '/card':
        if (args == null) {
          return MaterialPageRoute(builder: (context) => const ErrorPage());
        }
        return MaterialPageRoute(
          builder: (context) => CardPage(documentId: args as String),
        );

      case '/create':
        if (args != null) {
          return MaterialPageRoute(
              builder: (context) => CreateEvent(
                    argument: args as CardPageArgument,
                  ));
        }
        return MaterialPageRoute(builder: (context) => const CreateEvent());
      case '/MyAccountPage':
        return MaterialPageRoute(builder: (context) => MyAccountPage());
      case '/OtpPage':
        return MaterialPageRoute(
            builder: (context) => const OtpPage(
                  verificationId: '',
                ));

      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
