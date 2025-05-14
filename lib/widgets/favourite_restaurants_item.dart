import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:provider/provider.dart';

import '../models/hotel_room_model.dart';

class FavouriteRestaurantsteItem extends StatelessWidget {
  final ResturantModel favouriteResturant;

  const FavouriteRestaurantsteItem({
    super.key,
    required this.favouriteResturant,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder:
          (context, value, child) => ListTile(
            leading: Image.asset("${favouriteResturant.imagePath}"),
            title: Text(
              favouriteResturant.name ?? 'No Name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              '${favouriteResturant.rating} ⭐',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: GestureDetector(
              onTap: () {
                value.removeFromFavouriteRestaurants(favouriteResturant);
              },
              child: Icon(Icons.delete, color: Colors.red, size: 40),
            ),
          ),
    );
  }
}
