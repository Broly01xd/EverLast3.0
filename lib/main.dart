import 'package:flutter/material.dart';
// import 'package:everlast/pages/gen_otp.dart';
// import 'package:everlast/pages/today_page.dart';
// import 'package:everlast/pages/add.dart';
// import 'package:everlast/pages/profile_page.dart';
// import 'package:everlast/pages/tom_page.dart';
import 'package:everlast/utils/routes.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:everlast/pages/history_page.dart';
// import 'package:everlast/pages/otp_page.dart';

// import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/genotp',
      onGenerateRoute: MyRoutes.generateRoute,
    );
  }
}