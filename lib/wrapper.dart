import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everlast/pages/WelcomeScreen.dart';
import 'package:everlast/pages/bottom_nav_pages.dart';
import 'package:everlast/pages/card.dart';
import 'package:everlast/pages/gen_OTP.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/pages/user_details.dart';
import 'package:everlast/utils/dynamic_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  final User? user;
  const Wrapper({super.key, this.user});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late final ap;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    ap = Provider.of<AuthProvider>(context, listen: false);
    DynamicLinkProvider().initDynamicLink(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseDynamicLinks.instance.getInitialLink(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final dynamicLink = snapshot.data;

            if (widget.user == null) {
              return const WelcomeScreen();
            }

            return FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(widget.user?.uid).get(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final data = snapshot.data;

                if (data != null && data.exists) {

                  if (dynamicLink != null) {
                    return CardPage(documentId: dynamicLink.link.path.substring(1));
                  }
                  
                  return const BotNavPage();
                }

                return const UserInfromationScreen();

              },
            );
          },
        ),
      ),
    );
  }
}
