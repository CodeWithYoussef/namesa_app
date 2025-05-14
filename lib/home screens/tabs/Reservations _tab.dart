import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/widgets/reservation_item.dart';
import 'package:provider/provider.dart';

class ReservationsTab extends StatelessWidget {
  static const String routeName = "reservations tab";

  const ReservationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Reservations",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
        actions: [
          GestureDetector(
            onTap: () => showQuestions(context),
            // Call showQuestions when tapped
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(FontAwesomeIcons.circleQuestion, size: 30, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Consumer<HotelRooms>(
        builder: (context, value, child) {
          // Check if there are no reserved rooms
          if (value.reservedRooms.isEmpty) {
            return Center(
              child: Text(
                "No Reservations Found",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          // If there are reserved rooms, display them
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: value.reservedRooms.length,
                    itemBuilder: (context, index) {
                      final reservedRoom = value.reservedRooms[index];
                      return ReservationItem(
                        reservedRoom: reservedRoom,
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to show AlertDialog when the question icon is tapped
  void showQuestions(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Container(
            child: AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Center(
                child: Text(
                  "FAQ",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: PageScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(height: 2, color: Colors.white, thickness: 3),
                    SizedBox(height: 8),
                    Text(
                      "1. How Do I Cancel a Reservation?🧐",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "- By Clicking On The Delete Icon Below.💡",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Text(
                      "2. How Much Time Do I Have to Cancel My Reservation?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "- You can cancel your reservation at any time, except within 2 days of the check-in date.",
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                    const SizedBox(height: 8),

                    Divider(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(
                    'Close',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
