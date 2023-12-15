import 'package:ecom/home.dart';
import 'package:ecom/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecom/usermodel.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.help)],
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
          child: Container(
            width: 350.0,
            height: 520.0,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0)
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Color.fromARGB(255, 4, 22, 181)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: firstNameEditingController,
                    validator: (value) {
                      RegExp regExp = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("First Name cannot be Empty");
                      }
                      if (!regExp.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      firstNameEditingController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: "First Name",
                        hintStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: secondNameEditingController,
                    validator: (value) {
                      RegExp regExp = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Second Name cannot be Empty");
                      }
                      if (!regExp.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      secondNameEditingController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        hintText: "Second Name",
                        hintStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: emailEditingController,
                    validator: (value) {
                      RegExp regExp =
                          RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
                      if (value!.isEmpty) {
                        return (" Email cannot be Empty");
                      }
                      if (!regExp.hasMatch(value)) {
                        return ("Enter Valid Email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(Icons.mail, color: Colors.black),
                        hintText: "E-mail",
                        hintStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: passwordEditingController,
                    validator: (value) {
                      RegExp regExp = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("password Name cannot be Empty");
                      }
                      if (!regExp.hasMatch(value)) {
                        return ("Enter Valid name(Min. 6 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      passwordEditingController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon:
                            const Icon(Icons.vpn_key, color: Colors.black),
                        hintText: "password",
                        hintStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: confirmPasswordEditingController,
                    obscureText: true,
                    validator: (value) {
                      if (passwordEditingController.text !=
                          confirmPasswordEditingController.text) {
                        return "password dont match";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      confirmPasswordEditingController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon:
                            const Icon(Icons.vpn_key, color: Colors.black),
                        hintText: "Confirm password",
                        hintStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      signup(emailEditingController.text,
                          passwordEditingController.text);
                    },
                    icon: const Icon(Icons.app_registration),
                    label: const Text(
                      "Sign Up",
                      style: TextStyle(
                        letterSpacing: 3.0,
                        color: Colors.yellowAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => verifyemail())
          .then((value) => postDetailsToFirestore())
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
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

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully");
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  Future<void> verifyemail() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
    if (user.emailVerified) {
      print("Account verified");
    }
  }
}
