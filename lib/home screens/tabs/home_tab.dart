import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/auth%20provider/auth_provider.dart';
import 'package:namesa_yassin_preoject/home%20screens/reserve%20screens/reserve_event.dart';
import 'package:namesa_yassin_preoject/home%20screens/reserve%20screens/reserve_restaurant.dart';
import 'package:namesa_yassin_preoject/models/event_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:namesa_yassin_preoject/widgets/event_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/resturanant_item.dart';
import '../../widgets/rooms_item.dart';
import '../../widgets/search_bar_widget.dart';
import '../reserve screens/reserve_room.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "home tab";

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController searchBarController = TextEditingController();

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName =
        user?.displayName ?? user?.email?.split('@').first.trim() ?? "Guest";

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Consumer<HotelRooms>(
            builder:
                (context, value, child) => SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 67),

                        /// Greeting row
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              "Hello, $userName",
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            Icon(Icons.notifications_active_outlined, size: 30),
                          ],
                        ),

                        SizedBox(height: 15),

                        /// Search bar
                        SearchBarWidget(
                          textEditingController: searchBarController,
                        ),

                        SizedBox(height: 15),

                        Divider(height: 1, color: Colors.white, thickness: 2),

                        SizedBox(height: 15),

                        /// Popular Rooms title row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Available Rooms",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        /// Horizontal ListView of rooms or no result
                        value.allRooms.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No rooms found",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                            : SizedBox(
                              height: 340,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  HotelRoom eachRoom = value.allRooms[index];
                                  return RoomsItem(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReserveRoom(
                                                hotelRoom:
                                                    value.allRooms[index],
                                              ),
                                        ),
                                      );
                                    },
                                    hotelRoom: eachRoom,
                                    icon: Icon(Icons.favorite_border),
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(width: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: value.allRooms.length,
                                physics: BouncingScrollPhysics(),
                              ),
                            ),

                        SizedBox(height: 16),

                        /// Restaurants title row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Restaurants",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        value.allResturant.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No restaurants found",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                            : SizedBox(
                              height: 340,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  ResturantModel eachResturant =
                                      value.allResturant[index];
                                  return RestaurantItem(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReserveRestaurant(
                                                resturantModel:
                                                    value.allResturant[index],
                                              ),
                                        ),
                                      );
                                    },
                                    hotelResturant: eachResturant,
                                    icon: Icon(Icons.favorite_border),
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(width: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: value.allResturant.length,
                                physics: BouncingScrollPhysics(),
                              ),
                            ),

                        SizedBox(height: 16),

                        /// Restaurants title row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Events",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        value.allEvents.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No events found",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                            : SizedBox(
                              height: 340,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  EventModel eachEvent = value.allEvents[index];
                                  return EventItem(
                                    reservedEvent: eachEvent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReserveEvent(
                                                event: value.allEvents[index],
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(width: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: value.allEvents.length,
                                physics: BouncingScrollPhysics(),
                              ),
                            ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {});
  }
}
