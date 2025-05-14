import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import for animated text
import 'package:namesa_yassin_preoject/auth%20screens/auth_screen.dart'; // Your AuthScreen

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
    // Start a timer to navigate to the next screen after a certain duration.
    Future.delayed(const Duration(seconds: 8), () {
      // Navigate to the next screen with a fade transition
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => const AuthScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition for the screen transition
            var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(opacity: fadeAnimation, child: child);
          },
        ),
      );
    });

    // Start the fade-in effect
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040404),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Use AnimatedOpacity to fade the image in
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'assets/pictures/namesa bg final.png', // Your logo image path
                width: 400,
                height: 400,
              ),
            ),
            const SizedBox(height: 20),

            // Animated text
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Welcome to Namesa!',
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
                TyperAnimatedText(
                  'Your Journey With Royalty Begins...',
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1, // Animation repeats once
              pause: const Duration(seconds: 1), // Pause between animations
            ),
          ],
        ),
      ),
    );
  }
}
