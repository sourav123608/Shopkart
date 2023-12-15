import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecom/authstate.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        duration: 3000,
        splashIconSize: 200.0,
        splash: const Image(
          image: AssetImage("assets/images/icon2.png"),
        ),
        nextScreen: const Authstate(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
