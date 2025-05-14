import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/hotel_room_model.dart';

class FavouriteItem extends StatelessWidget {
  final HotelRoom favouriteRoom;

  const FavouriteItem({super.key, required this.favouriteRoom});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder:
          (context, value, child) => ListTile(
            leading: Image.asset(favouriteRoom.imagePath),
            title: Text(
              favouriteRoom.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              '${favouriteRoom.price} EGP',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: GestureDetector(
              onTap: () {
                value.removeFromFavouriteRooms(favouriteRoom);
              },
              child: Icon(Icons.delete, color: Colors.red, size: 40),
            ),
          ),
    );
  }
}
