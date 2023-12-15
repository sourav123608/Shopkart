import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Passreset extends StatefulWidget {
  const Passreset({Key? key}) : super(key: key);

  @override
  State<Passreset> createState() => _PassresetState();
}

class _PassresetState extends State<Passreset> {
  final TextEditingController _id = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _validate = false;
  Future reset() async {
    auth.sendPasswordResetEmail(email: _id.text.trim());
    Fluttertoast.showToast(
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        msg: 'Link sent to your email',
        toastLength: Toast.LENGTH_LONG,
        fontSize: 12.0,
        backgroundColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, blurRadius: 13.0, spreadRadius: 2.0)
              ],
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 19, 140, 240),
                  Color.fromARGB(255, 10, 29, 199)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black),
          height: 200,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _id,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintText: "Email-id",
                      errorText: _validate ? 'Cant be empty?' : null,
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 15.0)),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _id.text.isEmpty ? _validate = true : _validate = false;
                        if (_validate == false) {
                          reset();
                        }
                      });
                    },
                    icon: const Icon(Icons.login),
                    label: const Text(
                      "Reset",
                      style: TextStyle(
                          letterSpacing: 3.0,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
