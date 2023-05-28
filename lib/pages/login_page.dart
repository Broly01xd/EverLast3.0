import 'package:flutter/material.dart';
import 'package:everlast/utils/routes.dart';

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async{
    if(_formKey.currentState!.validate()){
    setState(() {
                  changeButton = true;
                });

                await Future.delayed(Duration(seconds: 1));
                await Navigator.pushNamed(context, MyRoutes.homeRoute );
                setState(() {
                  changeButton = false;
                });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child:SingleChildScrollView(
      child: Form(
        key: _formKey,
         child: Column(
        children:[
          Image.asset("rout/images/undraw_Events_re_98ue.png",fit: BoxFit.cover,
          ),
          SizedBox(
            height: 15.0,
            ),
          Text(
            "Welcome $name ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
      
          SizedBox(
            height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Column(
                children: [
              TextFormField(
              decoration: InputDecoration(
                hintText: "Enter username",
                labelText: "username",
               ), 
               
               validator: (value) {
                if (value!.isEmpty) {
                  return "Username cannot be empty";
                }
                return null;
               },
               onChanged: (value) {
                 name = value;
                 setState(() {});
               },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
                labelText: "password",
               ),
               validator: (value) {
                if (value!.isEmpty) {
                  return "password cannot be empty";
                }
                else if (value.length < 6) {
                  return "password length should be atleast 6";
                }
                return null;
               },
             
            ),
            SizedBox(
            height: 40.0,
            ),
            Material(
              color: Colors.pinkAccent,
               borderRadius: BorderRadius.circular(changeButton?50:8),
            child : InkWell(
              onTap: () => moveToHome(context),
              child:AnimatedContainer(
                duration: Duration(seconds: 1),
              width: changeButton?50: 150,
              height: 50,
              alignment: Alignment.center,
              child:changeButton
              ?Icon(
                Icons.done,
                color: Colors.white,
                ):
                 Text(
                "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
              ),
             
              ),
            ),
            ),
            ],
            ),
            )
            
            ],
      ),
      ),
      ));
  }
}
