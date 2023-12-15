import 'dart:async';

import 'package:ecom/language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Authstate extends StatefulWidget {
  const Authstate({Key? key}) : super(key: key);

  @override
  State<Authstate> createState() => _AuthstateState();
}

class _AuthstateState extends State<Authstate> {
  late StreamSubscription<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    user = auth.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print(user.uid);
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? Language.id : Home.id,

      ///key value pair
      routes: {
        Home.id: (context) => const Home(),
        Language.id: (context) => const Language(),
      },
    );
  }
}
