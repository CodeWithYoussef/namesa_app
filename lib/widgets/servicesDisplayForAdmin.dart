import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/service_model.dart';
import 'package:provider/provider.dart';

class DisplayServiceForAdmin extends StatefulWidget {
  final ServiceModel serviceModel;
  final VoidCallback onApprove;

  const DisplayServiceForAdmin({
    super.key,
    required this.serviceModel,
    required this.onApprove,
  });

  @override
  State<DisplayServiceForAdmin> createState() => _DisplayServiceForAdminState();
}

class _DisplayServiceForAdminState extends State<DisplayServiceForAdmin> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final focusColor = Theme.of(context).focusColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.2),
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// USER ID BOX
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.serviceModel.username ?? "Guest",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// SERVICES TITLE
              Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "User Needs:",
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// SERVICE DETAILS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServiceItem(
                      context, "Laundry", widget.serviceModel.laundry),
                  _buildServiceItem(
                      context, "Room Service", widget.serviceModel.roomService),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3,
                    height: 3,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Price: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).focusColor),
                      ),
                      Text(
                        '${widget.serviceModel.roomPrice + widget.serviceModel.extraPrice} EGP',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// APPROVE BUTTON
              MaterialButton(
                height: 48,
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () async {
                  await Provider.of<HotelRooms>(context, listen: false)
                      .markServiceAsDone(widget.serviceModel.uid);
                  widget.onApprove();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "✅ The request has been approved, Admin!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      duration: const Duration(seconds: 3),
                      elevation: 6,
                    ),
                  );

                },
                child: Text(
                  'Approve',
                  style: textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget for displaying a service item with Yes/No
  Widget _buildServiceItem(BuildContext context, String title, bool? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Icon(
            value == true ? Icons.check_circle : Icons.cancel,
            color: value == true ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '$title: ${value == true ? 'Yes' : 'No'}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).focusColor),
          ),
        ],
      ),
    );
  }
}
