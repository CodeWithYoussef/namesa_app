import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/widgets/reserved_event_item.dart';
import 'package:provider/provider.dart';

class AdminReservedEvents extends StatelessWidget {
  static const String routeName = "Admin Reserved Events";

  const AdminReservedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<HotelRooms>(context).reservedEvents;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reserved Events",
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
          events.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      size: 64,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No Events Are Reserved Now",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return ReservedEventItem(
                    onTap: () {},
                    reservedEventItem: events[index],
                  );
                },
              ),
    );
  }
}
