import 'package:flutter/material.dart';

class ReservationsTab extends StatelessWidget {
  static const String routeName = "reservations tab";

  const ReservationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "ReservationsTab",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 60),
            ),
          ),
        ],
      ),
    );
  }
}
