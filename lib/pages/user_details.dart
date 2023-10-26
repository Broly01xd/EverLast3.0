import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../pages/bottom_nav_pages.dart';
import '../provider/auth_provider.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});
  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  // final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    // bioController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    print("uncle ji photo");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String uname = ap.userModel.name;
    String email = ap.userModel.email;
    nameController.text = uname;
    emailController.text = email;
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    var _formKey;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: CircleAvatar(
                          backgroundImage: (image != null
                              ? FileImage(image!)
                              : NetworkImage(
                                  ap.userModel.profileImage,
                                )) as ImageProvider<Object>?,
                          radius: 50,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  // name field

                                  TextField(
                                    hintText: "$uname",
                                    icon: Icons.account_circle,
                                    inputType: TextInputType.name,
                                    maxLines: 1,
                                    controller: nameController,
                                  ),

                                  // email

                                  TextField(
                                    hintText: '$email',
                                    icon: Icons.email,
                                    inputType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    controller: emailController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () {
                            storeData();
                            Navigator.pushNamed(context, '/BotNavPage');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget TextField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  //store user data to database
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
    if (image != "") {
      ap.saveUserDataToFirebase(
          context: context,
          userModel: userModel,
          profilePic: image!,
          onSuccess: () {
            //once data is saved we need to store it locally
            ap.saveUserDataToSP().then(
                  (value) => ap.setSigIn().then(
                        (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BotNavPage(),
                            ),
                            (route) => false),
                      ),
                );
          });
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}