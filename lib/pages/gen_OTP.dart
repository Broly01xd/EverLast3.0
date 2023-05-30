import 'package:flutter/material.dart';


class Genotp extends StatefulWidget {
  const Genotp({super.key});

  // final String title;

  @override
  State<Genotp> createState() => _GenotpState();
}

class _GenotpState extends State<Genotp> {
  TextEditingController countrycode = TextEditingController();

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

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
                width: 260,
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
              // IntlPhoneField(
              //   decoration: const InputDecoration(
              //     labelText: 'Phone Number',
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(),
              //     ),
              //   ),
              //   onChanged: (phone) {
              //     print(phone.completeNumber);
              //   },
              //   onCountryChanged: (country) {
              //     print('Country changed to: ' + country.name);
              //   },
              // ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/enterotp");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(192, 52, 217, 1),
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