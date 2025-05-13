import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:provider/provider.dart';
import '../../widgets/favourite_item.dart';

class FavouritesTab extends StatelessWidget {
  static const String routeName = "offers tab";

  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            "Favourite",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Colors.white, // Divider color
              height: 2,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Consumer<HotelRooms>(
          builder: (context, value, child) {
            final favourites = value.favouriteRooms;
            if (favourites.isEmpty) {
              return Center(
                child: Text(
                  'No favourites yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                return FavouriteItem(
                  favouriteRoom: favourites[index], favouriteList: null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
