import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namesa_yassin_preoject/auth%20screens/auth_screen.dart';
import 'package:namesa_yassin_preoject/home%20screens/home_screen.dart'; // Replace with your actual HomeScreen

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash screen";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Start fade-in animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });

    // Check for cached user and navigate accordingly
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User is signed in, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) => const HomeScreen(),
            transitionsBuilder: (_, animation, __, child) {
              var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(opacity: fadeAnimation, child: child);
            },
          ),
        );
      } else {
        // No user signed in, navigate to AuthScreen
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) => const AuthScreen(),
            transitionsBuilder: (_, animation, __, child) {
              var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(opacity: fadeAnimation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040404),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'assets/pictures/namesa bg final.png',
                width: 400,
                height: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
