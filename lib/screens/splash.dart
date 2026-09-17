import 'dart:async';

import 'package:HAPPYPETS/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();
    _redirectTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: value,
                    child: Image.asset(
                      'assets/HAPPYPETS.jpg',
                      width: screenSize.shortestSide * 0.6,
                      height: screenSize.shortestSide * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenSize.height * 0.04),
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
