import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/resturant_model.dart';

class ReservedRestaurantItem extends StatelessWidget {
  final ResturantModel reservedRestaurant;
  final VoidCallback onTap;

  const ReservedRestaurantItem({
    super.key,
    required this.reservedRestaurant,
    required this.onTap,
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
                                "${reservedRestaurant.imagePath}",
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
                              value.cancelRestaurantReservation(
                                reservedRestaurant,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Restaurant Reservation Cancelled ✅',
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
                        "${reservedRestaurant.name}",
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

                          Text(
                            "${reservedRestaurant.rating}",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "(${reservedRestaurant.reviews?.toInt()} Reviews)",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
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
