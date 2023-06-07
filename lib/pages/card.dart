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
      backgroundColor: Colors.purple,
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
              SizedBox(height: 15),
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
              SizedBox(height: 20),
              TicketWidget(
                width: 380,
                height: 550,
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
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "By org.NAME",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(height: 30),
                        Icon(Icons.location_on, color: Colors.red, size: 35),
                        Text("St Aloysius College",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange)),
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
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          Container(
            height: 30,
            width: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.purple.shade900,
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

//         child: Center(
//           child: Container(
//             width: 305,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Ticket(
//                   innerRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10.0),
//                       bottomRight: Radius.circular(10.0)),
//                   outerRadius: BorderRadius.all(Radius.circular(10.0)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     offset: Offset(0, 4.0),
                  //     blurRadius: 2.0,
                  //     spreadRadius: 2.0,
                  //     color: Color.fromRGBO(196, 196, 196, .76),
                  //   )
                  // ],
//                   child: Image.asset(
//                     "rout/images/cards.jpg",
//                     width: 500,
//                     height: 200,
//                   ),
//                 ),
//                 Ticket(
//                   innerRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10.0),
//                       topRight: Radius.circular(10.0)),
//                   outerRadius: BorderRadius.all(Radius.circular(10.0)),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 4),
//                       blurRadius: 2.0,
//                       spreadRadius: 2.0,
//                       color: Color.fromRGBO(196, 196, 196, .76),
//                     )
//                   ],
//                   child: Container(
//                     color: Colors.white,
//                     width: 300,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.remove,
//                                 color: Colors.lightBlue,
//                               ),
//                               Text(
//                                 '2 TICKET',
//                                 style: TextStyle(fontSize: 18.0),
//                               ),
//                               Icon(
//                                 Icons.add,
//                                 color: Colors.lightBlue,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(height: 0.0),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text('Date'),
//                                     FittedBox(
//                                       child: Text(
//                                         '08/17   ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18.0),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                                 child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text('Time'),
//                                   FittedBox(
//                                     child: Text(
//                                       '9:00PM',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 18.0),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )),
//                             Expanded(
//                                 child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text('Price'),
//                                   FittedBox(
//                                     child: Text(
//                                       '\$15.00  ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 18.0),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )),
//                           ],
//                         ),
//                         Container(
//                           width: double.infinity,
//                           color: Colors.lightBlue,
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Center(
//                             child: Text(
//                               'BUY TICKETS',
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 16.0),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
