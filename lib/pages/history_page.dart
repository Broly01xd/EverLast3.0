import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
 final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 55,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
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
                    top: 10,
                  left: 120,
                    child: Container(
                      padding: EdgeInsets.symmetric( horizontal: 35),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        " History ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}


      
        
 



