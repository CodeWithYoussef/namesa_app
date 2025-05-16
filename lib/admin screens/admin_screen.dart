import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/admin%20screens/admin_reserved_rooms.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

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
                  Expanded(
                    child: Image.asset("assets/pictures/namesa bg final.png"),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
