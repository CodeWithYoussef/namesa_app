import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_room_model.dart';
import '../../models/hotel_rooms.dart';

class ReserveRoom extends StatefulWidget {
  static const String routeName = "reserve room";

  final HotelRoom hotelRoom;

  const ReserveRoom({super.key, required this.hotelRoom});

  @override
  State<ReserveRoom> createState() => _ReserveRoomState();
}

class _ReserveRoomState extends State<ReserveRoom> {
  DateTime? selectedCheckInDate;
  DateTime? selectedCheckOutDate;
  String? selectedPaymentMethod;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // GlobalKey for form validation

  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.hotelRoom.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Consumer<HotelRooms>(
        builder:
            (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.hotelRoom.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      infoRow("Room Type:", widget.hotelRoom.name),
                      infoRow("Room Rate:", "${widget.hotelRoom.rating}"),
                      infoRow(
                        "Room Price:",
                        "${widget.hotelRoom.price.toInt()}",
                      ),
                      infoRow(
                        "Number Of Reviews:",
                        "${widget.hotelRoom.reviews.toInt()}",
                      ),
                      infoRow(
                        "Number Of Beds:",
                        "${widget.hotelRoom.numOfBeds.toInt()}",
                      ),
                      const SizedBox(height: 8),
                      rowWithIcon(Icons.wifi, widget.hotelRoom.wifi),
                      const SizedBox(height: 8),
                      rowWithIconAsset(
                        "assets/pictures/gym.png",
                        widget.hotelRoom.gym,
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap:
                            () => showPopUpDetails(context, widget.hotelRoom),
                        child: Card(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            width: 230,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Reserve",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(fontSize: 35),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).focusColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget rowWithIcon(IconData icon, bool provided) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).focusColor, size: 25),
        const SizedBox(width: 8),
        Text(
          provided ? "Provided" : "Not Provided",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget rowWithIconAsset(String asset, bool provided) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(asset),
          color: Theme.of(context).focusColor,
          size: 25,
        ),
        const SizedBox(width: 8),
        Text(
          provided ? "Provided" : "Not Provided",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  void showPopUpDetails(BuildContext context, HotelRoom hotelRoom) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Consumer<HotelRooms>(
            builder:
                (context, value, child) => StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return SizedBox(
                      height: 600,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reservation Details",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              thickness: 1,
                              height: 2,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 16),
                            buildDateSelector(
                              label: "Check-In Date",
                              date: selectedCheckInDate,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (picked != null) {
                                  setState(() => selectedCheckInDate = picked);
                                  setStateDialog(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            buildDateSelector(
                              label: "Check-Out Date",
                              date: selectedCheckOutDate,
                              onTap: () async {
                                final DateTime checkIn =
                                    selectedCheckInDate ?? DateTime.now();
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: checkIn.add(
                                    const Duration(days: 1),
                                  ),
                                  firstDate: checkIn.add(
                                    const Duration(days: 1),
                                  ),
                                  // 👈 Enforces different date
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (picked != null) {
                                  setState(() => selectedCheckOutDate = picked);
                                  setStateDialog(() {});
                                }
                              },
                            ),

                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  "Payment: ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: selectedPaymentMethod,
                                  dropdownColor: Theme.of(context).primaryColor,
                                  items:
                                      ['Card', 'Cash'].map((String method) {
                                        return DropdownMenuItem<String>(
                                          value: method,
                                          child: Text(
                                            method,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.copyWith(
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () => selectedPaymentMethod = value,
                                    );
                                    setStateDialog(() {});
                                  },
                                  hint: Text(
                                    "Select",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  underline: const SizedBox(),
                                ),
                              ],
                            ),
                            if (selectedPaymentMethod == 'Card') ...[
                              const SizedBox(height: 16),
                              Form(
                                key: _formKey, // Form with validation
                                child: Column(
                                  children: [
                                    // Removed cardNumberController
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: expiryDateController,
                                      keyboardType: TextInputType.datetime,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(5),
                                        // MM/YY format
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'Expiry Date (MM/YY)',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an expiry date';
                                        }
                                        if (!RegExp(
                                          r"^(0[1-9]|1[0-2])\/[0-9]{2}$",
                                        ).hasMatch(value)) {
                                          return 'Enter a valid expiry date (MM/YY)';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: cvvController,
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'CVV',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the CVV';
                                        }
                                        if (value.length != 3) {
                                          return 'CVV must be 3 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Cancel",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      final isCard =
                                          selectedPaymentMethod == 'Card';
                                      final formValid =
                                          _formKey.currentState?.validate() ??
                                          false;
                                      final datesFilled =
                                          selectedCheckInDate != null &&
                                          selectedCheckOutDate != null;
                                      final hotelRoomProvider =
                                          Provider.of<HotelRooms>(
                                            context,
                                            listen: false,
                                          );
                                      final isAlreadyReserved =
                                          hotelRoomProvider.isRoomReserved(
                                            widget.hotelRoom,
                                          );

                                      if (!datesFilled) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please fill all reservation details',
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      if (isCard) {
                                        if (!formValid) return;

                                        if (!isAlreadyReserved) {
                                          hotelRoomProvider.reserveRoom(
                                            widget.hotelRoom,
                                          );
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Room Reserved ✅'),
                                            ),
                                          );
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'This room is already reserved ❌',
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        // Cash payment
                                        if (!isAlreadyReserved) {
                                          hotelRoomProvider.reserveRoom(
                                            widget.hotelRoom,
                                          );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Room Reserved ✅'),
                                            ),
                                          );
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'This room is already reserved ❌',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },

                                    child: Text(
                                      "Confirm",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        );
      },
    );
  }

  Widget buildDateSelector({
    required String label,
    required DateTime? date,
    required Function() onTap,
  }) {
    return Row(
      children: [
        Text(
          "$label:",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).focusColor),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            date != null
                ? '${date.day}/${date.month}/${date.year}'
                : 'Not selected', // Safe check for null
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
