import 'package:flutter/material.dart';

class Genotp extends StatefulWidget {
  const Genotp({super.key});

  @override
  State<Genotp> createState() => _GenotpState();
}

class _GenotpState extends State<Genotp> {
  TextEditingController mobile = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "rout/images/OTP1.png",
                width: 250,
                height: 260,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone before getting  started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 85,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mobile,
                      maxLength: 10,
                      // decoration: buildInputDecoration(Icons.phone, "Phone"),
                      keyboardType: TextInputType.phone,
                      onChanged: (mobile) {
                        formKey.currentState?.validate();
                      },
                      validator: (mobile) {
                        if (mobile!.isEmpty || mobile.length != 10) {
                          return "Please Enter a Phone Number";
                        } else if (!RegExp(
                                r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                            .hasMatch(mobile)) {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: "Enter Phone Number",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(24)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 20.0),
                        ),
                        hintText: "Enter Your Moblie Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 0.5,
              ),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, "/enterotp");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(192, 52, 217, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Generate OTP",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}