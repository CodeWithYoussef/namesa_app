import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = "profile tab";

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "ProfileTab",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 60),
            ),
          ),
        ],
      ),
    );
  }
}
