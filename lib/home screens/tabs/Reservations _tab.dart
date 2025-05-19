import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';

import '../../widgets/reservation_item.dart';
import '../../widgets/reserved_event_item.dart';
import '../../widgets/reserved_resturant_item.dart';

class ReservationsTab extends StatelessWidget {
  static const String routeName = "reservations tab";

    ReservationsTab({super.key});

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
              child: Icon(
                FontAwesomeIcons.circleQuestion,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<HotelRooms>(
          builder: (context, value, child) {
            // Check if there are no reserved rooms
            if (value.reservedRooms.isEmpty &&
                value.reservedRestaurants.isEmpty &&
                value.reservedEvents.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 50),
                    Icon(Icons.event_busy, color: Colors.white, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      "No Reservations Found",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),

                  // -------- Reserved Hotel Rooms --------
                  if (value.reservedRooms.isNotEmpty) ...[
                    Text(
                      "Reserved Rooms",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: value.reservedRooms.length,
                      itemBuilder: (context, index) {
                        final reservedRoom = value.reservedRooms[index];
                        return ReservationItem(
                          reservedRoom: reservedRoom,
                          onTap: () {
                            if(reservedRoom.needService!){
                              showServices(context, reservedRoom,);
                            }
                            else{
                              return;
                            }



                          },
                        );
                      },
                    ),
                  ],

                  const SizedBox(height: 32),

                  // -------- Reserved Restaurants --------
                  if (value.reservedRestaurants.isNotEmpty) ...[
                    Text(
                      "Reserved Resturant",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: value.reservedRestaurants.length,
                      itemBuilder: (context, index) {
                        final reservedRestaurant =
                            value.reservedRestaurants[index];
                        return ReservedRestaurantItem(
                          reservedRestaurant: reservedRestaurant,
                          onTap: () {},
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 32),
                  // -------- Reserved Events --------
                  if (value.reservedEvents.isNotEmpty) ...[
                    Text(
                      "Reserved Events",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: value.reservedEvents.length,
                      itemBuilder: (context, index) {
                        final reservedEvents = value.reservedEvents[index];
                        return ReservedEventItem(
                          reservedEventItem: reservedEvents,
                          onTap: () {},
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to show AlertDialog when the question icon is tapped
  void showQuestions(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(height: 2, color: Colors.white, thickness: 3),
                  SizedBox(height: 8),
                  Text(
                    "1. How To Request Service?🧐",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "- By Clicking On The Current Reserved Room Below.💡",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Text(
                    "2. How Do I Cancel a Reservation?🧐",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "- By Clicking On The Delete Icon Below.💡",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    "3. How Much Time Do I Have Before Canceling My Reservation?🧐",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "- You can cancel your reservation at any time, except within 2 days of the check-in date.💡",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    "4. Why Is My Reservation Is Pending?🧐",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "- This Means That Your Reservation Isn't Conformed Yet By The Staff.💡",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).focusColor,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
    );
  }

  void showServices(BuildContext context, HotelRoom reservedRoom) {
    // Local copies of service states for dialog controls
    bool roomService = reservedRoom.roomService ?? false;
    bool foodDelivery = reservedRoom.foodDelivery ?? false;
    bool laundry = reservedRoom.laundry ?? false;


    double basePrice = reservedRoom.price;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Calculate extra charges based on selected services
            double extraCharge = 0;
            if (roomService) extraCharge += 100;
            if (foodDelivery) extraCharge += 150;
            if (laundry) extraCharge += 100;

            double totalPrice = basePrice + extraCharge;

            return AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Center(
                child: Text(
                  "Services",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(height: 2, color: Colors.white, thickness: 3),
                    const SizedBox(height: 8),

                    // Show static services availability
                    buildServiceInfo(context, "Wi-Fi", reservedRoom.wifi),
                    buildServiceInfo(context, "Gym", reservedRoom.gym),

                    Divider(),

                    // Interactive toggles for optional services
                    buildServiceSwitch(
                      context,
                      "Room Service",
                      roomService,
                      (val) => setState(() => roomService = val),
                      100,
                    ),
                    buildServiceSwitch(
                      context,
                      "Food Delivery",
                      foodDelivery,
                      (val) => setState(() => foodDelivery = val),
                      150,
                    ),
                    buildServiceSwitch(
                      context,
                      "Laundry",
                      laundry,
                      (val) => setState(() => laundry = val),
                      100,
                    ),

                    Divider(),

                    const SizedBox(height: 16),

                    // Dynamic Total Price display
                    Text(
                      "Total Price: USD ${totalPrice.toInt().toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Update model with new selections and extra price
                    reservedRoom.roomService = roomService;
                    reservedRoom.foodDelivery = foodDelivery;
                    reservedRoom.laundry = laundry;
                    reservedRoom.extraPrice = extraCharge;
                    Provider.of<HotelRooms>(context,listen: false).sendUserServices(reservedRoom);
                    reservedRoom.needService=false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Your requested services is pending ⏳'),
                        backgroundColor:
                            Theme.of(
                              context,
                            ).scaffoldBackgroundColor, // or any color you want
                        duration: Duration(seconds: 3),
                      ),
                    ); // optional
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Confirm',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildServiceInfo(BuildContext context, String title, bool available) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ${available ? "Available" : "Not Available"}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildServiceSwitch(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
    double price,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$title (+USD ${price.toStringAsFixed(0)})",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).focusColor,
        ),
      ],
    );
  }
}
