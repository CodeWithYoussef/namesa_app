import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hotel_rooms.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const SearchBarWidget({super.key, required this.textEditingController});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {}); // Rebuild when text changes to show/hide clear icon
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      onChanged: (value) {
        Provider.of<HotelRooms>(context, listen: false).search(value);
      },
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).shadowColor,
        hintText: "Search",
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.search, color: Colors.white),

        // Show clear button only if text is not empty
        suffixIcon:
            widget.textEditingController.text.isEmpty
                ? null
                : IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    widget.textEditingController.clear();
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
