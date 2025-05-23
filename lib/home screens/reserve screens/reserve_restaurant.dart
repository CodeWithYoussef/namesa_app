import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/resturant_model.dart';
import 'package:provider/provider.dart';
import '../../models/hotel_rooms.dart';

class ReserveRestaurant extends StatefulWidget {
  final ResturantModel resturantModel;

  const ReserveRestaurant({super.key, required this.resturantModel});

  @override
  State<ReserveRestaurant> createState() => _ReserveRestaurantState();
}

class _ReserveRestaurantState extends State<ReserveRestaurant> {
  final _numberOfChairsController = TextEditingController();
  int? enteredChairs;
  final _formKey = GlobalKey<FormState>();

  void numericInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'Enter Number of Chairs',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).focusColor,
              ),
            ),
            content: TextFormField(
              controller: _numberOfChairsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter a number',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_numberOfChairsController.text.isNotEmpty) {
                    int? number = int.tryParse(_numberOfChairsController.text);
                    if (number != null && number > 0 && number < 17) {
                      setState(() {
                        enteredChairs = number;
                      });
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a number from 1 to 16'),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Submit',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _numberOfChairsController.dispose();
    super.dispose();
  }

  Widget buildInfoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).focusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "${widget.resturantModel.name}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<HotelRooms>(
          builder:
              (context, value, child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    // Image
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
                          "${widget.resturantModel.imagePath}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    buildInfoRow(
                      context,
                      "Restaurant Name:",
                      "${widget.resturantModel.name}",
                    ),
                    buildInfoRow(
                      context,
                      "Restaurant Rate:",
                      widget.resturantModel.rating.toString(),
                    ),
                    buildInfoRow(
                      context,
                      "Number Of Reviews:",
                      widget.resturantModel.reviews?.toInt().toString() ?? "0",
                    ),

                    // Chairs Input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Number Of Chairs:",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => numericInputDialog(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).focusColor,
                            ),
                            child: Text(
                              enteredChairs == null
                                  ? "Tap to Enter"
                                  : "Chairs: $enteredChairs",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    const Divider(
                      height: 20,
                      endIndent: 40,
                      indent: 40,
                      thickness: 3,
                    ),
                    const SizedBox(height: 32),

                    Container(
                      width: 290,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Our Restaurants Menu",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    GestureDetector(
                      onTap: () {
                        if (value.reservedRooms.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please reserve a room before reserving a restaurant',
                              ),
                            ),
                          );
                          return;
                        }
                        if (enteredChairs == null || enteredChairs! <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter the number of chairs',
                              ),
                            ),
                          );
                          return;
                        }
                        // Proceed to reserve restaurant
                        value.reserveRestaurant(widget.resturantModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Restaurant Reserved Successfully ✅'),
                          ),
                        );
                        Navigator.pop(context);
                      },
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
                    const SizedBox(height: 128),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

// Reusable widget to build info rows
Widget buildInfoRow(BuildContext context, String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // In case wrapping occurs
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).focusColor,
            ),
            overflow: TextOverflow.ellipsis, // optional
            maxLines: 2, // optional
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis, // optional
            maxLines: 2, // optional
          ),
        ),
      ],
    ),
  );
}
