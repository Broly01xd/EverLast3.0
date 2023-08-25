import 'package:everlast/pages/bottom_nav_pages.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/pages/widgets/custom_button.dart';
import 'package:everlast/utils/dynamic_links.dart';
import 'package:everlast/utils/routes.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gen_OTP.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  late final ap;

  @override
  void initState() {
    ap = Provider.of<AuthProvider>(context, listen: false);
    DynamicLinkProvider().initDynamicLink(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Welcome Image
              Image.asset(
                "rout/images/pop.jpeg",
                height: 300,
              ),
              //text
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Never a better time than now to start",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //start Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, MyRoutes.genotpRoute);
                  },
                  // when true fetch shared pred data
                  text: "Get Started",
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
