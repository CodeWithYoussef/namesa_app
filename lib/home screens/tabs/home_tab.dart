import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_room_model.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/resturanant_item.dart';
import '../../widgets/rooms_item.dart';
import '../../widgets/search_bar_widget.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "home tab";

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Consumer<HotelRooms>(
            builder:
                (context, value, child) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                              "Hello, Max",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            Icon(Icons.notifications_active_outlined, size: 25),
                          ],
                        ),

                        SizedBox(height: 15),

                        /// Search bar
                        SearchBarWidget(),

                        SizedBox(height: 43),

                        /// Popular Rooms title row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Rooms",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "See All",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(fontSize: 15),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        /// Horizontal ListView of rooms
                        SizedBox(
                          height: 340,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              HotelRoom eachRoom = value.allRooms[index];
                              return RoomsItem(
                                onTap: () {},
                                hotelRoom: eachRoom,
                                icon: Icon(Icons.favorite_border),
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(width: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: value.allRooms.length,
                            physics:
                                BouncingScrollPhysics(), // enables horizontal scroll only
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
                            Text(
                              "See All",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(fontSize: 15),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        SizedBox(
                          height: 340,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              ResturantModel eachResturant =
                                  value.allResturant[index];
                              return RestaurantItem(
                                onTap: () {},
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
