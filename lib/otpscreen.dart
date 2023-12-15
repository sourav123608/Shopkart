import 'package:ecom/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  final String phone;
  final String verificationId;

  const Otpscreen(this.phone, this.verificationId, {Key? key})
      : super(key: key);

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final TextEditingController _pincontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(shadows: [
      Shadow(color: Color.fromARGB(255, 0, 0, 0), blurRadius: 10.0)
    ], fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Login"),
        backgroundColor: Colors.black,
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
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'verify +91-${widget.phone}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Pinput(
                  length: 6,
                  controller: _pincontroller,
                  pinAnimationType: PinAnimationType.fade,
                  defaultPinTheme: defaultPinTheme,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Didn't Recieve OTP?",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Send again",
                    style: TextStyle(
                        color: Color.fromARGB(255, 1, 18, 207),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 395,
              ),
              SizedBox(
                height: 50,
                width: 400,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black)),
                    onPressed: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      try {
                        var credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: _pincontroller.text);
                        auth.signInWithCredential(credential).then(
                          (value) async {
                            if (value.user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                  (route) => false);
                            }
                          },
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Error"),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        ));
                      }
                    },
                    child: const Text(
                      "DONE",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20,
                        letterSpacing: 3.0,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
