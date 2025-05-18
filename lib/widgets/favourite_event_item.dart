import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';

class FavouriteEventItem extends StatelessWidget {
  final EventModel favouriteEvent;
  final VoidCallback? onTap;

  const FavouriteEventItem({
    super.key,
    required this.favouriteEvent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder:
          (context, value, child) => ListTile(
            leading: Image.asset(
              "${favouriteEvent.imagePath}",
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            title: Text(
              "${favouriteEvent.name}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              "VIP: ${favouriteEvent.price1?.toInt()} EGP | Normal: ${favouriteEvent.price2?.toInt()} EGP",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: GestureDetector(
              onTap: () {
                value.removeFromFavouriteEvents(favouriteEvent);
              },
              child: Icon(Icons.delete, color: Colors.red, size: 40),
            ),
          ),
    );
  }
}
