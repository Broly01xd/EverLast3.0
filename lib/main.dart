// import 'package:everlast/api/notification_api.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/utils/routes.dart';
import 'package:everlast/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  // tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: GoogleFonts.lato().fontFamily,
            primaryTextTheme: GoogleFonts.latoTextTheme()),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: MyRoutes.wrapperRoute,
        home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final user = snapshot.data;
                return Wrapper(user: user,);
              },
            ),
        onGenerateRoute: MyRoutes.generateRoute,
      ),
    );
  }
}
