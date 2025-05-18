import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/widgets/reservation_item.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_rooms.dart';

class AdminReservedRooms extends StatelessWidget {
  static const String routeName = "Admin Reserved Rooms";

  const AdminReservedRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<HotelRooms>(context).reservedRooms;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reserved Rooms",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:
          rooms.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel, size: 64, color: Colors.grey.shade600),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        "No Rooms Are Reserved Now",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return ReservationItem(
                    reservedRoom: rooms[index],
                    onTap: () {
                      // Handle tap if needed
                    },
                  );
                },
              ),
    );
  }
}
