import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/event_model.dart';
import '../../models/hotel_rooms.dart';

class ReserveEvent extends StatefulWidget {
  final EventModel event;

  const ReserveEvent({super.key, required this.event});

  @override
  State<ReserveEvent> createState() => _ReserveEventState();
}

class _ReserveEventState extends State<ReserveEvent> {
  final _ticketCountController = TextEditingController();
  int? ticketCount;
  final _formKey = GlobalKey<FormState>();

  void ticketInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'Enter Number of Tickets',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).focusColor,
              ),
            ),
            content: TextFormField(
              controller: _ticketCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Tickets Number',
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
                  int? number = int.tryParse(_ticketCountController.text);
                  if (number != null && number > 0 && number <= 10) {
                    setState(() => ticketCount = number);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter 1 to 10 tickets')),
                    );
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
    _ticketCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.event.name}", style: theme.textTheme.bodyLarge),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<HotelRooms>(
        builder:
            (context, value, child) => Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage("${widget.event.imagePath}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  buildInfoRow(context, "Event Name:", "${widget.event.name}"),
                  buildInfoRow(context, "Event Date:", "Date: Upcoming 🕓"),

                  // Ticket Count
                  Row(
                    children: [
                      Text(
                        "Tickets:",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.focusColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => ticketInputDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: theme.focusColor,
                          ),
                          child: Text(
                            ticketCount == null
                                ? "Tap to Enter"
                                : "$ticketCount Ticket(s)",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Reserve Button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (ticketCount != null && ticketCount! > 0) {
                          value.reserveEvent(
                            widget.event,
                          ); // Update this method
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Event Reserved Successfully ✅'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter number of tickets'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 230,
                        height: 70,
                        decoration: BoxDecoration(
                          color: theme.focusColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Reserve Event",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget buildInfoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
