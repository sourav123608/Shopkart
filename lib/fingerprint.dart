// ignore_for_file: unused_local_variable, unused_field

import 'package:ecom/login.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class Fingerprint extends StatefulWidget {
  const Fingerprint({Key? key}) : super(key: key);

  @override
  State<Fingerprint> createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {
  final LocalAuthentication auth = LocalAuthentication();
  String? _authorized;
  Future<bool> authenticateIsAvailable() async {
    final isAvailable = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  Future<void> _authenticate() async {
    var authenticated = false;
    try {
      setState(() {
        _authorized = 'Authenticating';
      });
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
      );
      setState(() {
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    // ignore: dead_code
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    // ignore: dead_code
    if (authenticated) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
