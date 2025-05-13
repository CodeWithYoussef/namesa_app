import 'package:flutter/material.dart';

class OffersTab extends StatelessWidget {
  static const String routeName = "offers tab";

  const OffersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "OffersTab",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 60),
            ),
          ),
        ],
      ),
    );
  }
}
