import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "rout/images/404_errorbird.png",
            // "rout/images/error_404.png",
            width: 350,
            height: 350,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Page Not Found',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Oops! We're sorry,the page you requested could not be found, Please go back to the Homepage.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 60,
            width: 180,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(192, 52, 217, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Go To Home",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
