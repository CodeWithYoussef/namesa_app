import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';

class EventItem extends StatelessWidget {
  final EventModel reservedEvent;
  final VoidCallback onTap;

  const EventItem({
    super.key,
    required this.reservedEvent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder: (context, provider, child) {
        final isFavourite = provider.isFavouriteEvent(reservedEvent);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 285,
            height: 330,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Event Image + Favorite Icon
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                      height: 183,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage("${reservedEvent.imagePath}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 20,
                      child: IconButton(
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: isFavourite ? Colors.red : Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          if (isFavourite) {
                            provider.removeFromFavouriteEvents(reservedEvent);
                          } else {
                            provider.addToFavouriteEvents(reservedEvent);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Event Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "${reservedEvent.name}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                /// Prices
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "VIP: ${reservedEvent.price1?.toInt()} EGP\nNormal: ${reservedEvent.price2?.toInt()} EGP",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Date: Upcoming 🕓",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
