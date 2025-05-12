import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namesa_yassin_preoject/theme/base_theme.dart';
import 'package:namesa_yassin_preoject/theme/light_theme.dart';

import 'auth screens/auth_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BaseTheme lightTheme = LightTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme.themeData,
      routes: {AuthScreen.routeName: (context) => const AuthScreen()},
      initialRoute: AuthScreen.routeName,
    );
  }
}
