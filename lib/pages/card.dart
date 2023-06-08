import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

// import 'package:flutter_ticket/flutter_ticket.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 131, 13, 133),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/create");
                      // Add button onPressed logic here
                      // print('Add button pressed');
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.purple,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0.01),
                      primary: Colors.white,
                    ),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   child: Icon(
                  //     Icons.arrow_back_ios_new_outlined,
                  //     color: Colors.purple,
                  //     size: 20,
                  //   ),
                  // ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Invitation Card".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.01),
              Center(
                child: Text(
                  "Embrace life, create everlasting cherished memories.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200),
                ),
              ),
              SizedBox(height: 10),
              TicketWidget(
                width: 380,
                height: 500,
                isCornerRounded: true,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 210,
                          // width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              "rout/images/cards.jpg",
                              width: 370,
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Event Name",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "By NAME",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(height: 30),
                        Icon(Icons.location_on, color:Color.fromARGB(255, 141, 4, 151), size: 35),
                        Text("St Aloysius College",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w100,
                                color: Colors.black)),
                        SizedBox(height: 30),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                EventDetails(
                                  'Time',
                                  '12:30 pm',
                                ),
                                EventDetails(
                                  'Date',
                                  '12-July-2023',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add");
                      // Add button onPressed logic here
                      // print('Add button pressed');
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0.8),
                    primary:Color.fromARGB(255, 163, 62, 170),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget EventDetails(String title, String details) => Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w100,
              fontSize: 25,
            ),
          ),
          Container(
            height: 30,
            width: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 141, 4, 151),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              details,
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
}

