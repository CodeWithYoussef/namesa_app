import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_room_model.dart';
import '../../models/hotel_rooms.dart';
import '../../widgets/reservation_item.dart';

class AdminReservedRooms extends StatefulWidget {
  static const String routeName = "Admin Reserved Rooms";

  const AdminReservedRooms({super.key});

  @override
  State<AdminReservedRooms> createState() => _AdminReservedRoomsState();
}

class _AdminReservedRoomsState extends State<AdminReservedRooms> {
  List<HotelRoom> _adminReservedRooms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAdminReservedRooms();
  }

  Future<void> loadAdminReservedRooms() async {
    final provider = Provider.of<HotelRooms>(context, listen: false);
    final rooms = await provider.loadAllReservedRoomsAdmin();
    setState(() {
      _adminReservedRooms = rooms;
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _adminReservedRooms.isEmpty
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _adminReservedRooms.length,
                  itemBuilder: (context, index) {
                    return ReservationItem(
                      reservedRoom: _adminReservedRooms[index],
                      onTap: () {},
                    );
                  },
                ),
    );
  }
}
