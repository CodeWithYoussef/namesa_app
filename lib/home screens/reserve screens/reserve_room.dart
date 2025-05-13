import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

class ReserveRoom extends StatelessWidget {
  static const String routeName = "reserve room";

  final HotelRoom hotelRoom;

  const ReserveRoom({super.key, required this.hotelRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "${hotelRoom.name}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Consumer<HotelRooms>(
        builder:
            (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "${hotelRoom.imagePath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Room Type:",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${hotelRoom.name}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Room Rate:",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${hotelRoom.rating}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Room Price:",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${hotelRoom.price?.toInt()}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Number Of Reviews:",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${hotelRoom.reviews?.toInt()}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Number Of Beds:",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Theme.of(context).focusColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${hotelRoom.numOfBeds?.toInt()}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.wifi,
                            color: Theme.of(context).focusColor,
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            hotelRoom.wifi != false
                                ? "Provided"
                                : "Not Provided",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageIcon(
                            const AssetImage("assets/pictures/gym.png"),
                            color: Theme.of(context).focusColor,
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            hotelRoom.gym != false
                                ? "Provided"
                                : "Not Provided",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          value.reserveRoom(hotelRoom);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Room Reserved ✅')),
                          );
                        },
                        child: Container(
                          width: 230,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Reserve",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(fontSize: 35),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
