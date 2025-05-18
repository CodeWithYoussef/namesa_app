import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/event_model.dart';
import '../../models/hotel_rooms.dart';
import '../../widgets/reserved_event_item.dart';

class AdminReservedEvents extends StatefulWidget {
  static const String routeName = "Admin Reserved Events";

  const AdminReservedEvents({super.key});

  @override
  State<AdminReservedEvents> createState() => _AdminReservedEventsState();
}

class _AdminReservedEventsState extends State<AdminReservedEvents> {
  List<EventModel> _adminReservedEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAdminReservedEvents();
  }

  Future<void> loadAdminReservedEvents() async {
    final provider = Provider.of<HotelRooms>(context, listen: false);
    final events = await provider.loadAllReservedEventsAdmin();
    setState(() {
      _adminReservedEvents = events;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reserved Events",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _adminReservedEvents.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available_outlined, size: 64, color: Colors.grey.shade600),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                "No Events Are Reserved Now",
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        itemCount: _adminReservedEvents.length,
        itemBuilder: (context, index) {
          return ReservedEventItem(
            reservedEventItem: _adminReservedEvents[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
