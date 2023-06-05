import 'package:flutter/material.dart';

class CreateEvent extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(250),
                        bottomRight: Radius.circular(250),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 120,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        " Event Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
       Expanded(
  child: SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "Enter Event Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                height: 1,
                
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextFormField(
              decoration: InputDecoration(labelText: "Event Name :"),
  
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextFormField(
              decoration: InputDecoration(labelText: "Name :"),
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return "Enter Full Name";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextFormField(
              decoration: InputDecoration(labelText: "Date:"),
              // validator: (value) {
              //   if (value!.isEmpty ||
              //       !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value!)) {
              //     return "Enter  Date";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextFormField(
              decoration: InputDecoration(labelText: "Time:"),
              // validator: (value) {
              //   if (value!.isEmpty ||
              //       !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value!)) {
              //     return "Enter Time";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextFormField(
              decoration: InputDecoration(labelText: "Location :"),
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
              //     return "Enter Location";
              //   } else {
              //     return null;
              //   }
              // },
            ),
          ],
        ),
      ),
    ),
  ),
),

        Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Expanded(child: Container()),
    Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final SnackBar snackBar = SnackBar(content: Text('Creating Invitation'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
          primary: Colors.purple,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        child: Icon(Icons.arrow_forward),
      ),
    ),
  ],
),



          ],
        ),
      ),
    );
  }
}
