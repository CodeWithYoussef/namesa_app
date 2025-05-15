import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/event_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/resturant_model.dart';

class ReservedEventItem extends StatelessWidget {
  final EventModel reservedEventItem;
  final VoidCallback onTap;

  const ReservedEventItem({
    super.key,
    required this.onTap,
    required this.reservedEventItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder:
          (context, value, child) => Card(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 285,
                height: 320,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Restaurant Image with Price and Delete
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                "${reservedEventItem.imagePath}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 20,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
                            onPressed: () {
                              value.cancelEventReservation(reservedEventItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Event Reservation Cancelled ✅',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// Restaurant Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "${reservedEventItem.name}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),

                    /// Rating Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_outlined,
                            color: Colors.amber,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
