import 'dart:io';
import 'package:everlast/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Uploadinvi extends StatefulWidget {
  const Uploadinvi({Key? key});

  @override
  State<Uploadinvi> createState() => _UploadinviState();
}

class _UploadinviState extends State<Uploadinvi> {
  final picker = ImagePicker();
  String? _pickedImagePath;
  bool changeButton = false;

  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImagePath = pickedImage.path;
      });
    } else {
      // User canceled the picker
      print('Image picking canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(111),
                        bottomRight: Radius.circular(111),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/create"); 
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(8),
                              primary: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 110,
                    child: Container(
                      child: Text(
                        "Upload Invitation",
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
            SizedBox(height: 20),
            Image.asset(
              "rout/images/upload.png",
              width: 260,
              height: 350,
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _openImagePicker(); // Call function to open image picker
                },
                icon: Icon(Icons.image),
                label: Text('Select Image'),
              ),
            ),
            if (_pickedImagePath != null) ...[
              SizedBox(height: 16),
              Image.file(
                File(_pickedImagePath!),
                width: 200,
                height: 200,
              ),
            ],
            SizedBox(height: 20),
            Material(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
              child: InkWell(
                splashColor: Colors.purple,
                onTap: () async {
                  setState(() {
                    changeButton = true;
                  });
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushNamed(context, MyRoutes.cadrRoute);
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: changeButton ? 45 : 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: changeButton
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                        
                      : Text(
                          "Create Invitation",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
