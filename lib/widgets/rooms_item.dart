import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';
import '../models/hotel_room_model.dart';

class RoomsItem extends StatefulWidget {
  final HotelRoom hotelRoom;
  final VoidCallback onTap;
  final Widget? icon;

  const RoomsItem({
    super.key,
    required this.hotelRoom,
    required this.onTap,
    this.icon,
  });

  @override
  State<RoomsItem> createState() => _RoomsItemState();
}

class _RoomsItemState extends State<RoomsItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HotelRooms>(
      builder: (context, hotelRoomsProvider, child) {
        bool isFavourite = hotelRoomsProvider.favouriteRooms.contains(
          widget.hotelRoom,
        );

        return Card(
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 285,
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
                            image: AssetImage("${widget.hotelRoom.imagePath}"),
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
                            "LE ${widget.hotelRoom.price.toInt()}/Day",
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
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFavourite) {
                                hotelRoomsProvider.removeFromFavouriteRooms(
                                  widget.hotelRoom,
                                );
                              } else {
                                hotelRoomsProvider.addToFavouriteRooms(
                                  widget.hotelRoom,
                                );
                              }
                            });
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
                          "${widget.hotelRoom.rating}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${widget.hotelRoom.reviews.toInt()}) Review",
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
                      "${widget.hotelRoom.name}",
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
                        "${widget.hotelRoom.numOfBeds.toInt()}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Icon(
                        Icons.wifi,
                        color: Theme.of(context).focusColor,
                        size: 25,
                      ),
                      Text(
                        widget.hotelRoom.wifi != false
                            ? "Provided"
                            : "Not Provided",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      ImageIcon(
                        const AssetImage("assets/pictures/gym.png"),
                        color: Theme.of(context).focusColor,
                        size: 25,
                      ),
                      Text(
                        widget.hotelRoom.gym != false
                            ? "Provided"
                            : "Not Provided",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ],
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
