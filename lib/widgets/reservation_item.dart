import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../models/hotel_room_model.dart';

class ReservationItem extends StatelessWidget {
  final HotelRoom reservedRoom;
  final VoidCallback onTap;

  const ReservationItem({
    super.key,
    required this.reservedRoom,
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
                height: 330,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Room Image with Price and Favorite
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 183,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(reservedRoom.imagePath),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 4,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 18,
                          ),
                          width: 112,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0x99003366),
                          ),
                          child: Center(
                            child: Text(
                              "LE ${reservedRoom.price.toInt()}/Day",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 50,
                            ),
                            onPressed: () {
                              value.cancelRoomReservation(reservedRoom);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Room Reservation Cancelled ✅'),
                                ),
                              );
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
                            "${reservedRoom.rating}",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              fontSize: 24,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${reservedRoom.reviews.toInt()}) Review",
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

                    /// Room Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        reservedRoom.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Features Row (Beds, Wifi, Gym)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.bed,
                          color: Theme.of(context).focusColor,
                          size: 25,
                        ),
                        Text(
                          "${reservedRoom.numOfBeds.toInt()}",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                        Icon(
                          Icons.wifi,
                          color: Theme.of(context).focusColor,
                          size: 25,
                        ),
                        Text(
                          reservedRoom.wifi != false ? "Provided" : "N/P",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                        ImageIcon(
                          const AssetImage("assets/pictures/gym.png"),
                          color: Theme.of(context).focusColor,
                          size: 25,
                        ),
                        Text(
                          reservedRoom.gym != false ? "Provided" : "N/P",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
