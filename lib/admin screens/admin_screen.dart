import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/admin%20screens/admin_reserved_rooms.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../auth provider/auth_provider.dart';
import '../auth screens/auth_screen.dart';
import 'admin_reserved_events.dart';
import 'admin_reserved_restaurants.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = "Admin Screen";

  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Admin Dashboard",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<HotelRooms>(
        builder:
            (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  ///SizedBox
                  SizedBox(height: 18),

                  /// bg and buttons
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 320,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      ///Reserved Rooms
                      Positioned(
                        bottom: 210,
                        right: 72,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AdminReservedRooms.routeName,
                              );
                            },
                            child: Container(
                              width: 230,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Reserved Rooms",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).focusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///Reserved Restaurants
                      Positioned(
                        bottom: 120,
                        right: 72,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AdminReservedRestaurants.routeName,
                              );
                            },
                            child: Container(
                              width: 230,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Reserved Restaurants",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).focusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///Reserved Events
                      Positioned(
                        bottom: 30,
                        right: 72,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AdminReservedEvents.routeName,
                              );
                            },
                            child: Container(
                              width: 230,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Reserved Events",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).focusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  buttonMaker(
                    context,
                    () async {
                      ///Circular Progress Indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                      );

                      ///log out
                      try {
                        final authProvider =
                            Provider.of<AuthenticationProvider>(
                              context,
                              listen: false,
                            );
                        await authProvider.logOut();
                      } catch (e) {
                        debugPrint("Logout failed: $e");
                      }

                      /// Wait for 2 seconds before navigating
                      await Future.delayed(const Duration(seconds: 3));

                      Navigator.pop(context); // Close the loading dialog
                      Navigator.pushReplacementNamed(
                        context,
                        AuthScreen.routeName,
                      );
                    },

                    "Log Out",
                    60,
                    200,
                    Colors.transparent,
                    Theme.of(context).focusColor,
                    Theme.of(context).focusColor,
                  ),
                  Expanded(
                    child: Image.asset("assets/pictures/namesa bg final.png"),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget buttonMaker(
    BuildContext context,
    void Function() onTap,
    String text,
    double height,
    double width,
    Color backGroundColor,
    Color borderColor,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
