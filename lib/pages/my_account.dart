import 'dart:io';
import 'package:everlast/model/user_model.dart';
import 'package:everlast/pages/provider/auth_provider.dart';
import 'package:everlast/pages/user_details.dart';
import 'package:everlast/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final formKey = GlobalKey<FormState>();
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String uname = ap.userModel.name;
    String email = ap.userModel.email;
    return MultiProvider(providers: [
      Provider<AuthProvider>(create: (_) => AuthProvider()),
    ], child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // elevation: 0, // Remove elevation for a flat app bar
      ),
      backgroundColor: Colors.grey[100], // Light background color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(ap.userModel.profileImage),
                  radius: 80,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$uname',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              Text(
                '$email',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  storeData();
                  // Navigator.pushNamed(context, '/Userdetails');
                  Navigator.push(context, MaterialPageRoute(builder: (_) => UserInfromationScreen(
                    userModel: ap.userModel,
                  )));
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      profileImage: "",
      createdAt: '',
      phone: '',
      uid: '',
    );
  }
}
