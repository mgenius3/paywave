import 'package:flutter/material.dart';
import 'dart:async';
import 'package:paywave/presentation/routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
            'public/images/handshake.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
