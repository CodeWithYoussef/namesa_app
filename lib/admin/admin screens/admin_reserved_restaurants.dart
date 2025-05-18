import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/widgets/reserved_resturant_item.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_rooms.dart';

class AdminReservedRestaurants extends StatelessWidget {
  static const String routeName = "Admin Reserved Restaurants";

  const AdminReservedRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<HotelRooms>(context).reservedRestaurants;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reserved Restaurants",
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
      body:
          restaurants.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 64,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        "No Restaurants Are Reserved Now",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return ReservedRestaurantItem(
                    reservedRestaurant: restaurants[index],
                    onTap: () {},
                  );
                },
              ),
    );
  }
}
