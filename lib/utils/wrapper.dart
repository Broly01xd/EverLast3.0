import 'package:everlast/pages/WelcomeScreen.dart';
import 'package:everlast/pages/card.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'firebase_utils/dynamic_link.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

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

            final dynamicLink = snapshot.data?.link.path;

            if (dynamicLink != null) {
              return CardPage(documentId: dynamicLink.substring(1));
            }

            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}
