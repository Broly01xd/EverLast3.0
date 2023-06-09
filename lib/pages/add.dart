import 'package:flutter/material.dart';
import 'package:everlast/utils/add_events.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(111),
                      bottomRight: Radius.circular(111),
                    ),
                  ),
                ),
                   Center(
                    child: Container(
                      padding: EdgeInsets.only(top:20,),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Eventify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
              
            ),
            
          ),
          // Positioned(
          //           child: Container(
          
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
                          
          //                 SizedBox(width: 25),
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     Navigator.pushNamed(context, "/create");
          //                     // Add button onPressed logic here
          //                     print('Add button pressed');
          //                   },
          //                   child: Text(
          //                     '+',
          //                     style: TextStyle(
          //                       fontSize: 25,                              
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.purple,
          //                     ),
          //                   ),
          //                   style: ElevatedButton.styleFrom(
          //                     shape: CircleBorder(),
          //                     padding: EdgeInsets.all(10),
          //                     primary: Colors.white,
          //                   ),
          //                 ),
          //                 const Text(
          //                   "Create New",
          //                   style: TextStyle(
          //                     color: Colors.purple,
          //                     fontSize: 16,
                              
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           )),
          Container(
            child: Expanded(
              child: ListView(
                children: const [
                  EventsTile(
                      icon: Icons.cake,
                      eventName: 'Birthday Party',
                      eventWho: '',
                      eventDate: ''),
                 
                ],
              ),
            ),
          ),
          // Positioned(
                    Container(
          
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                         mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          
                          SizedBox(width: 35),
                          Padding(
                            padding: const EdgeInsets.only(right:23.5,bottom:8),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/create");
                                // Add button onPressed logic here
                                print('Add button pressed');
                              },
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 25,                              
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(10),
                                primary: Colors.white,
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(left:300,bottom: 20,),
                       child: const Text(
                              "Create New",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 16,
                                
                              ),
                            ),
                     ),
                  
        ],
      ),
    );
  }
}
