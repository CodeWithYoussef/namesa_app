import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/home%20screens/tabs/Reservations%20_tab.dart';
import 'package:namesa_yassin_preoject/home%20screens/tabs/home_tab.dart';
import 'package:namesa_yassin_preoject/home%20screens/tabs/favourites_tab.dart';
import 'package:namesa_yassin_preoject/home%20screens/tabs/profile_tab.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0; // ✅ Move this INSIDE the state class


  List<Widget> tabs = [
    HomeTab(),
    const FavouritesTab(),
     ReservationsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white,
              width: 3,
            )
          )
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {

              currentIndex = index; // ✅ Rebuilds the UI with the new screen
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourites"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Reservations"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}
