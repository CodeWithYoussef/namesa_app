import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:provider/provider.dart';

import '../models/hotel_rooms.dart';

class RestaurantItem extends StatelessWidget {
  final ResturantModel hotelResturant;
  final VoidCallback onTap;
  final Widget? icon;

  const RestaurantItem({
    super.key,
    required this.hotelResturant,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder: (context, provider, child) {
        final isFavourite = provider.isFavouriteRestaurant(hotelResturant);

        return GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 285,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image with favorite button
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: 183,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage("${hotelResturant.imagePath}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 20,
                        child: IconButton(
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.black,
                            size: 32,
                          ),
                          onPressed: () {
                            if (isFavourite) {
                              provider.removeFromFavouriteRestaurants(
                                hotelResturant,
                              );
                            } else {
                              provider.addToFavouriteRestaurants(
                                hotelResturant,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Rating Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Theme.of(context).focusColor,
                          size: 28,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${hotelResturant.rating}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${hotelResturant.reviews}) Review",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Restaurant Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "${hotelResturant.name}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Empty Features Row (can be filled later)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${hotelResturant.description}",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
