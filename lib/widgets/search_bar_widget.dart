import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hotel_rooms.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const SearchBarWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) {
        // Call the search method from provider
        Provider.of<HotelRooms>(context, listen: false).search(value);
      },
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).shadowColor,
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            textEditingController.clear();
            Provider.of<HotelRooms>(context, listen: false).search('');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
