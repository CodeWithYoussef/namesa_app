import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_rooms.dart';
import '../../models/resturant_model.dart';
import '../../widgets/reserved_resturant_item.dart';

class AdminReservedRestaurants extends StatefulWidget {
  static const String routeName = "Admin Reserved Restaurants";

  const AdminReservedRestaurants({super.key});

  @override
  State<AdminReservedRestaurants> createState() => _AdminReservedRestaurantsState();
}

class _AdminReservedRestaurantsState extends State<AdminReservedRestaurants> {
  List<ResturantModel> _adminReservedRestaurants = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAdminReservedRestaurants();
  }

  Future<void> loadAdminReservedRestaurants() async {
    final provider = Provider.of<HotelRooms>(context, listen: false);
    final restaurants = await provider.loadAllReservedRestaurantsAdmin();
    setState(() {
      _adminReservedRestaurants = restaurants;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reserved Restaurants",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _adminReservedRestaurants.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 64, color: Colors.grey.shade600),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        itemCount: _adminReservedRestaurants.length,
        itemBuilder: (context, index) {
          return ReservedRestaurantItem(
            reservedRestaurant: _adminReservedRestaurants[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
