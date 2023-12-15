import 'package:ecom/home.dart';
import 'package:ecom/otp.dart';
import 'package:ecom/passreset.dart';
import 'package:ecom/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;
  String? errorMessage;
  FirebaseAuth auth = FirebaseAuth.instance;

  // void doUserResetPassword() async {
  //   final ParseUser user = ParseUser(null, null, controllerEmail.text.trim());
  //   final ParseResponse parseResponse = await user.requestPasswordReset();
  //   if (parseResponse.success) {
  //     Message.showSuccess(
  //         context: context,
  //         message: 'Password reset instructions have been sent to email!',
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         });
  //   } else {
  //     Message.showError(context: context, message: parseResponse.error!.message);
  //   }
  // }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [Icon(Icons.help)],
          backgroundColor: Colors.black,
          title: const Text(
            "Login",
            style: TextStyle(
              letterSpacing: 2.0,
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, blurRadius: 13.0, spreadRadius: 2.0)
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 10, 29, 199)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: 270.0,
            height: 400.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _id,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email-id",
                        errorText: _validate1 ? 'Cant be empty?' : null,
                        hintStyle: const TextStyle(
                            color: Colors.white, fontSize: 15.0)),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _pass,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.yellowAccent),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        errorText: _validate2 ? 'Cant be empty?' : null,
                        hintStyle: const TextStyle(color: Colors.white)),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _pass.text.isEmpty
                              ? _validate2 = true
                              : _validate2 = false;
                          _id.text.isEmpty
                              ? _validate1 = true
                              : _validate1 = false;
                          if (_validate1 == false && _validate2 == false) {
                            login(_id.text, _pass.text);
                          }
                        });
                      },
                      icon: const Icon(Icons.login),
                      label: const Text(
                        "Login",
                        style: TextStyle(
                            letterSpacing: 3.0,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "   Does not have account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signup()));
                              }),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Passreset()));
                          },
                          child: const Center(
                            child: Text(
                              "Forgotten password?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const Otp())));
                          },
                          child: const Center(
                            child: Text(
                              "Sign Up with OTP?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void login(String email, String password) async {
    if (_validate1 == false && _validate2 == false) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login  Succesful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()))
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong_password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
}
