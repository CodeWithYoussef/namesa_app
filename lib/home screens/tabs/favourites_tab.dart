import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:namesa_yassin_preoject/widgets/favourite_restaurants_item.dart';
import 'package:provider/provider.dart';
import '../../widgets/favourite_item.dart';

class FavouritesTab extends StatelessWidget {
  static const String routeName = "offers tab";

  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            "Favourite",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(color: Colors.white, height: 2),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Consumer<HotelRooms>(
          builder: (context, value, child) {
            final favouriteRooms = value.favouriteRooms;
            final favouriteRestaurants =
                value.favouriteRestaurants; // Add this in provider

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -------- Favourite Hotel Rooms --------
                    Text(
                      "Favourite Hotel Rooms",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    favouriteRooms.isEmpty
                        ? Text(
                          'No favourite rooms yet',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: favouriteRooms.length,
                          itemBuilder: (context, index) {
                            return FavouriteItem(
                              favouriteRoom: favouriteRooms[index],
                            );
                          },
                        ),

                    const SizedBox(height: 32),

                    Divider(height: 2, thickness: 2, color: Colors.white),

                    const SizedBox(height: 32),

                    // -------- Favourite Restaurants --------
                    Text(
                      "Favourite Restaurants",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    favouriteRestaurants.isEmpty
                        ? Text(
                          'No favourite restaurants yet',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: favouriteRestaurants.length,
                          itemBuilder: (context, index) {
                            return FavouriteRestaurantsteItem(
                              favouriteResturant: favouriteRestaurants[index],
                            );
                          },
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
