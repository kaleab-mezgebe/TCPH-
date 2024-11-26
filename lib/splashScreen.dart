import 'dart:async';
import 'package:flutter/material.dart';
import 'loginPage.dart'; // Ensure this imports your LoginPage correctly

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for fading effect
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Set up fade animation from fully visible to invisible
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Trigger the navigation to LoginPage after 1 second
    Timer(const Duration(seconds: 1), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    _controller.forward().whenComplete(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: const AlwaysStoppedAnimation(1.0), // Always show
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/background_image.png', // Update with correct path of your image
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'እንኳዕ ብደሓን መፁ!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 60,
              child: CircularProgressIndicator(),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
