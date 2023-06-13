
import 'package:everlast/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:ticket_widget/ticket_widget.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});
  @override
  State<CardPage> createState() => _CardPageState();
}
class _CardPageState extends State<CardPage> {
  var color1 = Color.fromARGB(255, 139, 89, 148);
  var color2 = Colors.white;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 86, 12, 99),
                    Color.fromARGB(255, 73, 16, 81),
                    Color.fromARGB(255, 183, 76, 202),
                     Color.fromARGB(255, 74, 4, 87),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.33, 0.6, 1.0],
                ),
              ),
            child: Column(
              children: [
                Container(
                  height: 55,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // decoration: const BoxDecoration(
                        //   color: Colors.purple,
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(0),
                        //     topRight: Radius.circular(0),
                        //     bottomLeft: Radius.circular(250),
                        //     bottomRight: Radius.circular(250),
                        //   ),
                        // ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/Uploadinvi");
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: color2,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0.01),
                              primary: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 110, top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Invitation Card".toUpperCase(),
                              style: TextStyle(
                                color: color2,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: TicketWidget(
                        width: 380,
                        height: 300,
                        color: color2,
                        isCornerRounded: true,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 210,
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
                                    fontSize: 30,
                                    color: color1,
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  "NAME",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: color1,
                                    fontWeight: FontWeight.w100,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(height: 0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Icon(Icons.location_on, color: Color.fromARGB(248, 75, 4, 86), size: 35),
                Text(
                  "St Aloysius College",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                    color: color2,
                  ),
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 109),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add");
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: color1,
                    
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.symmetric(vertical:10.01,horizontal: 10,),
                    primary: color2,
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget EventDetails(String title, String details) => Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color2,
              fontWeight: FontWeight.w300,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 30,
            width: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(248, 75, 4, 86),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              details,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
}