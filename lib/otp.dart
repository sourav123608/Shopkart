import 'package:ecom/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
        backgroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.white],
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 160, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Find Your Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Enter your phone number linked",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                const Text("to your account.",
                    style: TextStyle(color: Colors.black)),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 20.0, height: 0.5),
                    controller: phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Phone Number",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: const TextStyle(fontSize: 15),
                        prefix: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "+91$phone",
                          ),
                        ),
                        prefixIcon: const Icon(Icons.keyboard_arrow_down)),
                    maxLength: 10,
                  ),
                ),
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                  size: 150.0,
                ),
                const SizedBox(
                  height: 145,
                ),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+91${phone.text}",
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {},
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.code)));
                            }
                          },
                          codeSent:
                              (String verificationId, int? resendToken) async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Otpscreen(phone.text, verificationId)));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                          timeout: const Duration(seconds: 60));
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        color: Color.fromARGB(255, 71, 160, 234),
                        fontSize: 20,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
