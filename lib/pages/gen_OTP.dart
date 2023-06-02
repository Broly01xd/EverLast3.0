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
                width: 300,
                height: 300,
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        child: TextFormField(
                          onChanged: (value) {
                            formKey.currentState?.validate();
                          },
                          controller: mobile,
                          maxLength: 10,
                          validator: (value) {
                            if (mobile.text.length != 10) {
                              return "Please Enter a Valid Phone Number";
                            }
                          },
                          keyboardType: TextInputType.number,
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
                    Align(
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/enterotp");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(192, 52, 217, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Generate OTP"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
